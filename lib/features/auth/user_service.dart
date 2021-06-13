import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_todo_app/core/firestore_service.dart';
import 'package:team_todo_app/utils/constants.dart';

import 'user_model.dart';

class UserService extends FirestoreService {
  @override
  String getCollectionPath() {
    return Collections.users;
  }

  Future<void> insert(UserModel user) async {
    await collection.doc(user.id).set(user.toMap());
  }

  Future<void> addTeamID(String userID, String teamID) {
    return getDocRef(userID).update({
      // Add teamID to existing array 'teamIDs'
      Fields.teamIDs: FieldValue.arrayUnion([teamID])
    });
  }

  Future<void> removeTeamID(String userID, String teamID) {
    return getDocRef(userID).update({
      // Remove teamID from existing array 'teamIDs'
      Fields.teamIDs: FieldValue.arrayRemove([teamID])
    });
  }

  Future<List<String>> getJoinedTeamIDs(String userID) async {
    final userSnapshot = await getDocSnap(userID);
    final userIDs = userSnapshot.get(Fields.teamIDs);
    return List.castFrom(userIDs).map<String>((e) => e).toList();
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
}
