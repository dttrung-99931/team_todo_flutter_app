import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/modules/common/services/notification_sender_service.dart';

import '../../base/firestore_service.dart';
import '../../constants/constants.dart';
import '../../utils/utils.dart';
import '../user/service.dart';
import 'components/team/components/action/action_model.dart';
import 'components/team/components/members/model.dart';
import 'components/team/components/todo_board/components/task/model.dart';
import 'model.dart';

class TeamService extends FirestoreService {
  final _userService = Get.find<UserService>();
  final _notiSenderService = Get.find<NotificationSenderService>();

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
      final ownerUserID = _userService.user.uid;
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
    final teamIDs = await _userService.getJoinedTeamIDs(_userService.user.uid);
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
    return getTeamsOf(_userService.user.uid);
  }

  Future<void> update(TeamModel teamModel) {
    var teamRef = getDocRef(teamModel.id);
    return teamRef.update(teamModel.toMap());
  }

  String get appUserID => _userService.user.uid;

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
      addAction(
        teamID,
        ActionModel.TYPE_ADD_TASK,
        task.id,
      ),
    ]);
  }

  Future<void> addAction(
    String teamID,
    String type,
    String taskID, {
    Map<String, String> updatedFields = const {},
    String notiTitle = 'Task notification',
  }) async {
    var docRef = getDocRef(teamID).collection(Collections.actions).doc();
    var action = ActionModel(
      taskID: taskID,
      type: type,
      date: DateTime.now(),
      userID: _userService.userID,
      updatedFields: updatedFields,
      id: docRef.id,
    );
    await docRef.set(action.toMap());
    await addNotiForMembers(action.id, teamID, notiTitle);
  }

  Future<void> addNotiForMembers(
      String actionId, String teamID, String notiTitle) async {
    var teamMemberIDs = await getTeamMemberIDs(teamID);
    var futures = teamMemberIDs.map<Future>(
        (userID) => addNotiForMember(userID, teamID, actionId, notiTitle));
    await Future.wait(futures);
  }

  Future<void> addNotiForMember(
    String userID,
    String teamID,
    String actionId,
    String notiTitle,
  ) async {
    _userService.addTaskNoti(userID, teamID, actionId).then((notiId) async {
      // Not send noti to the sender user
      // if (userID == _userService.userID) return;

      var fcmToken = await _userService.getFcmToken(userID);
      if (isNotNullAndEmpty(fcmToken)) {
        await _notiSenderService.send(fcmToken, notiId, notiTitle);
      }
    });
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

  Future<void> updateTask(
    String teamID,
    TaskModel task, {
    Map<String, String> updatedFields,
    String notiTitle,
  }) async {
    task.statusChangedDate = DateTime.now();
    await Future.wait([
      getTaskCollectionOf(teamID).doc(task.id).update(task.toMap()),
      addAction(
        teamID,
        ActionModel.TYPE_UPDATE_TASK,
        task.id,
        updatedFields: updatedFields,
      )
    ]);
  }

  /// @TODO: Update ActionModel to show who and what task of TYPE_DEL_TASK action
  Future<void> deleteTask(String teamID, String taskID) async {
    await Future.wait([
      getTaskDoc(teamID, taskID).delete(),
      addAction(teamID, ActionModel.TYPE_DEL_TASK, taskID)
    ]);
  }

  DocumentReference getTaskDoc(String teamID, String taskID) {
    return getTaskCollectionOf(teamID).doc(taskID);
  }

  Future<List<ActionModel>> getActionsIn(
      String teamID, List<String> actionIDs) async {
    final querySnap = await getDocRef(teamID)
        .collection(Collections.actions)
        .where(FieldPath.documentId, whereIn: actionIDs)
        .get();
    var actions = querySnap.docs
        .map(
          (e) => ActionModel.fromMap(e.data()),
        )
        .toList();
    var futures = actions.map(
      (e) => getTask(teamID, e.taskID).then((task) => e.task = task),
    );
    await Future.wait(futures);
    return actions;
  }

  Future<List<ActionModel>> getActions(String teamID) async {
    final querySnap = await getDocRef(teamID)
        .collection(Collections.actions)
        .orderBy(Fields.date, descending: true)
        .get();

    var actions = querySnap.docs
        .map(
          (e) => ActionModel.fromMap(e.data()),
        )
        .toList();

    var futures = actions.map(
      (e) => getTask(teamID, e.taskID).then((task) => e.task = task),
    );
    await Future.wait(futures);
    return actions;
  }

  Future<TaskModel> getTask(String teamID, String taskID) async {
    var taskSnap = await getTaskDoc(teamID, taskID).get();
    return TaskModel.fromMap(taskSnap.data());
  }
}
