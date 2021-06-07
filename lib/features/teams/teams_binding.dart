import 'package:get/get.dart';

import 'teams_controller.dart';
import 'teams_service.dart';

class TeamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamsService());
    Get.put(TeamsController());
  }
}
