import 'package:get/get.dart';

import 'controller.dart';

class TeamNotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamNotificationsController());
  }
}
