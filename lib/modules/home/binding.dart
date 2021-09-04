import 'package:get/get.dart';
import 'package:team_todo_app/modules/nteam/binding.dart';

import 'controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    TeamBinding().dependencies();
    Get.put(HomeController());
  }
}
