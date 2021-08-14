import 'package:get/get.dart';

import 'controller.dart';

class TeamActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamActivityController());
  }
}
