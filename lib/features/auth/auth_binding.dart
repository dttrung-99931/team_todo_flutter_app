import 'package:get/get.dart';

import 'auth-controller.dart';
import 'auth_service.dart';
import 'user_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(UserService());
    Get.put(AuthController());
  }
}
