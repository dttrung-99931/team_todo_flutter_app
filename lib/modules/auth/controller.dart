import 'package:get/get.dart';
import 'package:team_todo_app/utils/utils.dart';
import '../../base/base_controller.dart';
import '../user/service.dart';

class AuthController extends BaseController {
  final _isLoginScreen = true.obs;
  get isLoginScreen => _isLoginScreen.value;

  final _userService = Get.find<UserService>();

  bool hasLoggedIn() => _userService.hasLoggedIn();

  Future<bool> login(String email, String password) async {
    isLoading = true;
    var loginSuccessful = await _userService.login(email, password);
    isLoading = false;
    return loginSuccessful;
  }

  Future<bool> signUp(String email, String password) async {
    isLoading = true;
    var signupSuccessful = await _userService.signUp(email, password);
    isLoading = false;
    return signupSuccessful;
  }

  Future<void> signOut() async {
    await _userService.signOut();
  }

  void swithScreen() {
    _isLoginScreen.value = !_isLoginScreen.value;
  }
}
