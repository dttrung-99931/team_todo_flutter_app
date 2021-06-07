import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_todo_app/core/firestore_service.dart';
import 'package:team_todo_app/utils/constants.dart';

class UserService extends FirestoreService {
  Future<void> insert(User user) async {
    await collection(Collections.users)
        .doc(user.uid)
        .set({Fields.email: user.email});
  }

  Future<DocumentSnapshot> getUser(String userID) {
    return getUserRef(userID).get();
  }

  DocumentReference getUserRef(String userID) {
    return collection(Collections.users).doc(userID);
  }

  Future<void> addTeam(String userID, String teamID) async {
    return getUserRef(userID).update({
      // Add teamID to existing array 'teamIDs'
      Fields.teamIDs: FieldValue.arrayUnion([teamID])
    });
  }

  Future<List<String>> getJoinedTeamIDs(String userID) async {
    final userSnapshot = await getUser(userID);
    final userIDs = userSnapshot.get(Fields.teamIDs);
    return List.castFrom(userIDs).map<String>((e) => e).toList();
  }
}
