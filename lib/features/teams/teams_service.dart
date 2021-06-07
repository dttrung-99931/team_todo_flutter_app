import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/firestore_service.dart';
import 'package:team_todo_app/features/auth/auth_service.dart';
import 'package:team_todo_app/features/auth/user_service.dart';
import 'package:team_todo_app/features/teams/team_model.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

class TeamsService extends FirestoreService {
  final _userService = Get.find<UserService>();
  final _authService = Get.find<AuthService>();

  CollectionReference get _teams => collection(Collections.teams);

  /// Add a team
  ///
  /// First, set ownerUserID to [team].
  /// Then, add ownerUserID to [team.userIDs]
  ///
  /// @return the added team if adding successfully, otherwise null
  Future<TeamModel> add(TeamModel team) async {
    try {
      final newDocRef = _teams.doc();
      team.id = newDocRef.id;
      final ownerUserID = _authService.user.uid;
      team.ownerUserID = ownerUserID;
      team.userIDs.add(ownerUserID);
      await newDocRef.set(team.toMap());
      await _userService.joinTeam(ownerUserID, team.id);
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
        await _teams.where(FieldPath.documentId, whereIn: teamIDs).get();
    return querySnapshot.docs.map((e) => TeamModel.fromMap(e.data())).toList();
  }

  /// Delete a team
  ///
  /// First, unjoin all users from the team
  /// then delete team
  ///
  /// @param teamID
  Future<void> delete(String teamID) async {
    final teamRef = getTeamRef(teamID);
    final teamDoc = await teamRef.get();
    if (!teamDoc.exists) {
      // @TODO handle
      return;
    }
    final team = TeamModel.fromMap(teamDoc.data());
    team.userIDs.forEach((userID) async {
      await _userService.unjoinTeam(userID, teamID);
    });
    await teamRef.delete();
  }

  Future<DocumentSnapshot> getTeamDoc(String teamID) async {
    final teamRef = getTeamRef(teamID);
    final teamDoc = await teamRef.get();
    return teamDoc;
  }

  DocumentReference getTeamRef(String teamID) => _teams.doc(teamID);

  Future<List<TeamModel>> getTeamsOf(String userID) async {
    final teamIDs = await _userService.getJoinedTeamIDs(userID);
    return getTeams(teamIDs);
  }

  Future<List<TeamModel>> getMyTeams() async {
    return getTeamsOf(_authService.user.uid);
  }

  Future<void> update(TeamModel teamModel) {
    var teamRef = getTeamRef(teamModel.id);
    return teamRef.update(teamModel.toMap());
  }
}
