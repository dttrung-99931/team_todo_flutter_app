import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class FirebaseAuthService extends GetxService {
  final _auth = FirebaseAuth.instance;

  final _user = Rx<User>();
  User get user => _user.value;

  @override
  void onInit() {
    _user.value = _auth.currentUser;
    super.onInit();
  }

  Future<bool> login(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user.value = userCredential.user;
      return true;
    } catch (e) {
      print('loggiend failed $e');
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.value = userCredential.user;
      return true;
    } catch (e) {
      print('@@sign failed $e');
    }
    return false;
  }

  bool hasLoggedIn() {
    return user != null;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }
}
