import 'package:get/get.dart';

import 'controller.dart';

class JoinRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(JoinRequestController());
  }
}
