import 'package:get/get.dart';
import '../team/binding.dart';

import 'controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    TeamBinding().dependencies();
    Get.put(HomeController());
  }
}
