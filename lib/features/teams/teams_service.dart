import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/firestore_service.dart';
import 'package:team_todo_app/features/auth/auth_service.dart';
import 'package:team_todo_app/features/auth/user_service.dart';
import 'package:team_todo_app/features/teams/team/components/members/member_model.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/task_model.dart';
import 'package:team_todo_app/features/teams/team_model.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

import 'action_model.dart';

class TeamsService extends FirestoreService {
  final _userService = Get.find<UserService>();
  final _authService = Get.find<AuthService>();

  @override
  String getCollectionPath() {
    return Collections.teams;
  }

  /// Add a team
  ///
  /// First, set ownerUserID to [team].
  /// Then, add ownerUserID to [team.userIDs]
  ///
  /// @return the added team if adding successfully, otherwise null
  Future<TeamModel> add(TeamModel team) async {
    try {
      final newDocRef = collection.doc();
      team.id = newDocRef.id;
      final ownerUserID = _authService.user.uid;
      team.ownerUserID = ownerUserID;
      team.userIDs.add(ownerUserID);
      await newDocRef.set(team.toMap());
      await _userService.addTeam(ownerUserID, team.id);
      return team;
    } catch (e) {
      logd('Add team error $e');

      /// @FIXME
      return null;
    }
  }

  Future<List<TeamModel>> getTeams(List<String> teamIDs) async {
    if (teamIDs.isEmpty) {
      return [];
    }
    final querySnapshot =
        await collection.where(FieldPath.documentId, whereIn: teamIDs).get();
    return querySnapshot.docs.map((e) => TeamModel.fromMap(e.data())).toList();
  }

  Future<List<TeamModel>> getSuggestTeams(int count) async {
    final teamIDs = await _userService.getJoinedTeamIDs(_authService.user.uid);
    QuerySnapshot querySnap;
    if (teamIDs.isNotEmpty) {
      querySnap = await collection
          .where(FieldPath.documentId, whereNotIn: teamIDs)
          .limit(count)
          .get();
    } else {
      querySnap = await collection.limit(count).get();
    }

    return querySnap.docs.map((e) => TeamModel.fromMap(e.data())).toList();
  }

  /// Delete a team
  ///
  /// First, unjoin all users from the team
  /// then delete team
  ///
  /// @param teamID
  Future<void> delete(String teamID) async {
    final teamRef = getDocRef(teamID);
    final teamDoc = await teamRef.get();
    if (!teamDoc.exists) {
      // @TODO handle
      return;
    }
    final team = TeamModel.fromMap(teamDoc.data());
    team.userIDs.forEach((userID) async {
      await _userService.removeTeam(userID, teamID);
    });
    await teamRef.delete();
  }

  Future<List<TeamModel>> getTeamsOf(String userID) async {
    final teamIDs = await _userService.getJoinedTeamIDs(userID);
    return getTeams(teamIDs);
  }

  Future<List<TeamModel>> getMyTeams() async {
    return getTeamsOf(_authService.user.uid);
  }

  Future<void> update(TeamModel teamModel) {
    var teamRef = getDocRef(teamModel.id);
    return teamRef.update(teamModel.toMap());
  }

  String get appUserID => _authService.user.uid;

  Future<void> joinAppUserIntoTeam(String teamID) async {
    return joinTeam(teamID, appUserID);
  }

  Future<void> joinTeam(String teamID, String userID) async {
    await addUserID(teamID, userID);
    await _userService.addTeam(userID, teamID);
  }

  Future<void> addUserID(String teamID, userID) async {
    final team = getDocRef(teamID);
    return team.update({
      Fields.userIDs: FieldValue.arrayUnion([userID])
    });
  }

  Future<void> removeUserID(String teamID, userID) async {
    final team = getDocRef(teamID);
    return team.update({
      Fields.userIDs: FieldValue.arrayRemove([userID])
    });
  }

  Future<void> unjoinAppUserFromTeam(String teamID) async {
    return await unjoinMember(teamID, appUserID);
  }

  Future<void> unjoinMember(String teamID, String memberUserID) async {
    await removeUserID(teamID, memberUserID);
    return _userService.removeTeam(memberUserID, teamID);
  }

  Future<void> requestJoinTeam(String teamID) async {
    return getDocRef(teamID).update({
      Fields.pendingUserIDs: FieldValue.arrayUnion([appUserID])
    });
  }

  Future<void> removeJoinTeamRequest(String teamID, String userID) async {
    return getDocRef(teamID).update({
      Fields.pendingUserIDs: FieldValue.arrayRemove([userID])
    });
  }

  Future<TeamModel> getById(teamID) async {
    final teamSnap = await getDocSnap(teamID);
    return TeamModel.fromMap(teamSnap.data());
  }

  Future<List<MemberModel>> loadTeamMemebers(TeamModel team) async {
    final users = await _userService.getUsers(team.userIDs);
    return users.map((e) => MemberModel(e, e.id == team.ownerUserID)).toList();
  }

  Future<void> addTask(String teamID, TaskModel task) async {
    final taskRef = getTaskCollectionOf(teamID).doc();
    task.id = taskRef.id;
    await Future.wait([
      taskRef.set(task.toMap()),
      addAction(teamID, Action.TYPE_ADD_TASK, task.id)
    ]);
  }

  Future<void> addAction(String teamID, String type, String taskID) async {
    var action = Action(taskID: taskID, type: type, date: DateTime.now());
    var actionRef = await getDocRef(teamID)
        .collection(Collections.actions)
        .add(action.toMap());

    await addActionForMembers(actionRef.id, teamID);
  }

  Future<void> addActionForMembers(String actionId, String teamID) async {
    var teamMemberIDs = await getTeamMemberIDs(teamID);
    var futures = teamMemberIDs.map<Future>(
      (userID) => _userService.addNewAction(userID, teamID, actionId),
    );
    await Future.wait(futures);
  }

  getTeamMemberIDs(String teamID) async {
    var team = await getById(teamID);
    return team.userIDs;
  }

  CollectionReference getTaskCollectionOf(String teamID) =>
      getDocRef(teamID).collection(Collections.tasks);

  Future<List<TaskModel>> getasks(String teamID) async {
    final querySnap = await getTaskCollectionOf(teamID).get();
    return querySnap.docs.map((e) => TaskModel.fromMap(e.data())).toList();
  }

  Future<void> updateTask(String teamID, TaskModel task) async {
    task.statusChangedDate = DateTime.now();
    await Future.wait([
      getTaskCollectionOf(teamID).doc(task.id).update(task.toMap()),
      addAction(teamID, Action.TYPE_UPDATE_TASK, task.id)
    ]);
  }

  /// @TODO: Update ActionModel to show who and what task of TYPE_DEL_TASK action
  Future<void> deleteTask(String teamID, String taskID) async {
    await Future.wait([
      getTaskCollectionOf(teamID).doc(taskID).delete(),
      addAction(teamID, Action.TYPE_DEL_TASK, taskID)
    ]);
  }
}
