import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../common/services/notification_sender_service.dart';
import '../team/components/actions/model.dart';

import '../../base/firestore_service.dart';
import '../../constants/constants.dart';
import '../../utils/utils.dart';
import '../user/service.dart';
import '../team/components/members/model.dart';
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

    // Test handling error
    // Check if firestoerr throw no internet error
    // => Firestore won't throw any exceptioon if there's no internet
    final querySnapshot = await collection
        .where(
          FieldPath.documentId,
          whereIn: teamIDs,
        )
        .get(GetOptions(source: Source.server));
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

  Future<TeamModel> getByID(teamID) async {
    final teamSnap = await getDocSnap(teamID);
    return TeamModel.fromMap(teamSnap.data());
  }

  Future<List<MemberModel>> loadTeamMemebers(TeamModel team) async {
    final users = await _userService.getUsers(team.userIDs);
    return users.map((e) => MemberModel(e, e.id == team.ownerUserID)).toList();
  }

  Future<bool> containsAction(String teamID, String actionID) async {
    final docSnap = await getDocRef(teamID)
        .collection(Collections.actions)
        .doc(actionID)
        .get();
    return docSnap.exists;
  }
}
