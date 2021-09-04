import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../notification/model.dart';
import '../team/components/actions/model.dart';

import '../../base/firestore_service.dart';
import '../../constants/constants.dart';
import '../common/services/firebase_auth_service.dart';
import 'model.dart';
import '../teams/user_team_model.dart';

class UserService extends FirestoreService {
  final _authService = Get.find<FirebaseAuthService>();

  @override
  String getCollectionPath() {
    return Collections.users;
  }

  Future<void> insert(UserModel user) async {
    await collection.doc(user.id).set(user.toMap());
  }

  Future<void> addTeam(String userID, String teamID) async {
    var teams = getDocRef(userID).collection(Collections.teams);
    var userTeamDoc = teams.doc(teamID);
    var userTeam = UserTeamModel(newActionIDs: [], teamID: teamID);
    await userTeamDoc.set(userTeam.toMap());
  }

  Future<void> removeTeam(String userID, String teamID) async {
    var teams = teamCollection(userID);
    await teams.doc(teamID).delete();
  }

  CollectionReference teamCollection(String userID) =>
      getDocRef(userID).collection(Collections.teams);

  Future<List<String>> getJoinedTeamIDs(String userID) async {
    var teams = await teamCollection(userID).get();
    return teams.docs.map((e) => e.id).toList();
  }

  Future<List<UserModel>> getUsers(List<String> userIDs) async {
    if (userIDs.isEmpty) return [];
    final querySnapshot =
        await collection.where(FieldPath.documentId, whereIn: userIDs).get();
    final docs = querySnapshot.docs;
    return docs.map((doc) {
      return UserModel.fromMap(doc.data());
    }).toList();
  }

  Future<UserModel> getByID(userID) async {
    var userSnap = await getDocSnap(userID);
    return UserModel.fromMap(userSnap.data());
  }

  Future<bool> existsByEmail(String email) async {
    final query = await collection.where(Fields.email, isEqualTo: email).get();
    return query.docs.isNotEmpty;
  }

  Future<UserModel> getByEmail(String email) async {
    final query = await collection.where(Fields.email, isEqualTo: email).get();
    if (query.docs.isNotEmpty) {
      return UserModel.fromMap(query.docs.first.data());
    }
    return null;
  }

  Future<String> addTaskNoti(
      String userID, String teamID, String actionID) async {
    var notiDoc = getDocRef(userID).collection(Collections.notifications).doc();
    var noti = NotificationModel(
      id: notiDoc.id,
      referenceID: actionID,
      type: NotificationModel.TYPE_ACTION,
      date: DateTime.now(),
    );
    await notiDoc.set(noti.toMap());
    return noti.id;
  }

  DocumentReference<Map<String, dynamic>> teamDoc(
      String userID, String teamID) {
    return getDocRef(userID).collection(Collections.teams).doc(teamID);
  }

  Future<List<String>> getNewActionIDs(String userID, String teamID) async {
    var teamSnap = await teamDoc(userID, teamID).get();
    return List.castFrom(teamSnap.data()[Fields.notifications]);
  }

  Future<bool> login(String email, String password) async {
    return _authService.login(email, password);
  }

  Future<bool> signUp(String email, String password, String fcmToken) async {
    var signupSuccessful = await _authService.signUp(email, password);
    if (signupSuccessful) {
      final user = _authService.user;
      await insert(UserModel(
        id: user.uid,
        email: user.email,
        fcmToken: fcmToken,
      ));
    }
    // @TODO: return error code
    return signupSuccessful;
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  bool hasLoggedIn() {
    return _authService.user != null;
  }

  User get user => _authService.user;
  String get userID => user?.uid;

  Future<int> getNewNotiNum() async {
    var querySnap = await getNewNotis();
    return querySnap.docs.length;
  }

  Future<QuerySnapshot> getNewNotis() async {
    return getNotiCollection().where(Fields.isSeen, isEqualTo: false).get();
  }

  CollectionReference getNotiCollection() {
    return getDocRef(userID).collection(Collections.notifications);
  }

  /// Load [ActionModel.user] for actions
  Future<void> loadUsersForActions(List<ActionModel> actions) async {
    var futures = actions.map((action) {
      return getByID(action.userID).then((value) => action.user = value);
    });
    await Future.wait(futures);
  }

  Future<void> updateFCMToken(String fcmToken) async {
    await getDocRef(userID).update({Fields.fcmToken: fcmToken});
  }

  Future<String> getFcmToken(userID) async {
    var user = await getByID(userID);
    return user.fcmToken;
  }
}
