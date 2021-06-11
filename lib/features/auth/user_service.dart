import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_todo_app/core/firestore_service.dart';
import 'package:team_todo_app/utils/constants.dart';

class UserService extends FirestoreService {
  @override
  String getCollectionPath() {
    return Collections.users;
  }

  Future<void> insert(User user) async {
    await collection.doc(user.uid).set({Fields.email: user.email});
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
}
