import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_todo_app/utils/constants.dart';

class LoginController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final _auth = FirebaseAuth.instance;

  final _isLoginScreen = true.obs;
  get isLoginScreen => _isLoginScreen.value;

  final _user = Rx<User>();
  get user => _user.value;

  Future<bool> hasLoggedIn() async {
    return _auth.currentUser != null;
    // var prefs = await SharedPreferences.getInstance();
    // var userJson = prefs.getString(Constants.KEY_USER);
    // return userJson != null && userJson.isNotEmpty;
  }

  Future<bool> login(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user.value = userCredential.user;
      _isLoading.value = false;
      return true;
    } catch (e) {}
    print('@@loggiend failed');
    _isLoading.value = false;
    return false;
  }

  Future<bool> signUp(String email, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.value = userCredential.user;
      _isLoading.value = false;
      return true;
    } catch (e) {
      print('@@sign failed $e');
    }
    _isLoading.value = false;
    return false;
  }

  Future<void> _saveUser(User user) async {
    var prefs = await SharedPreferences.getInstance();
    var userJson = jsonEncode(user);
    prefs.setString(Constants.KEY_USER, userJson);
  }

  Future<void> signOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.KEY_USER, "");
  }

  void swithScreen() {
    _isLoginScreen.value = !_isLoginScreen.value;
  }
}
