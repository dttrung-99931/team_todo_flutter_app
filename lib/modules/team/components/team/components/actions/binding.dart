import 'package:get/get.dart';

import 'controller.dart';

class TeamActionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamActionController());
  }
}
