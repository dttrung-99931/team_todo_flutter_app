import 'package:get/get.dart';

import 'controller.dart';

class TeamPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamPreviewController());
  }
}
