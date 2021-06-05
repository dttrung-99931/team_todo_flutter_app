import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:team_todo_app/utils/constants.dart';

class UserService extends GetxService {
  final _fs = FirebaseFirestore.instance;

  Future<void> insert(User user) async {
    await _fs
        .collection(Collections.Users)
        .doc(user.uid)
        .set({Fields.email: user.email});
  }
}
