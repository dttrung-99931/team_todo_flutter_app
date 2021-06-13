import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';

import 'auth_service.dart';
import 'user_model.dart';
import 'user_service.dart';

class AuthController extends BaseController {
  final _isLoginScreen = true.obs;
  get isLoginScreen => _isLoginScreen.value;

  final _authService = Get.find<AuthService>();
  final _userService = Get.find<UserService>();

  bool hasLoggedIn() => _authService.hasLoggedIn();

  Future<bool> login(String email, String password) async {
    isLoading = true;
    var loginSuccessful = await _authService.login(email, password);
    isLoading = false;
    return loginSuccessful;
  }

  Future<bool> signUp(String email, String password) async {
    isLoading = true;
    var signupSuccessful = await _authService.signUp(email, password);
    if (signupSuccessful) {
      final user = _authService.user;
      await _userService.insert(UserModel(id: user.uid, email: user.email));
    }
    isLoading = false;
    return signupSuccessful;
  }

  Future<void> signOut() async {
    _authService.signOut();
  }

  void swithScreen() {
    _isLoginScreen.value = !_isLoginScreen.value;
  }
}
