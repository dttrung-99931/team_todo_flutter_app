import 'package:get/get.dart';

import 'controller.dart';

class MembersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MembersController());
  }
}
