import 'package:get/get.dart';

import 'controller.dart';
import 'service.dart';
import '../user/service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(UserService());
    Get.put(AuthController());
  }
}
