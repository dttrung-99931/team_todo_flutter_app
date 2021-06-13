import 'package:get/get.dart';

import 'members_controller.dart';

class MembersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MembersController());
  }
}
