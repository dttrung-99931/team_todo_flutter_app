import 'package:get/get.dart';

import 'modules/auth/controller.dart';
import 'modules/user/firebase_auth_service.dart';
import 'modules/user/service.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseAuthService());
    // UserService required FirebaseAuthService
    Get.put(UserService());
    Get.put(AuthController());
  }
}
