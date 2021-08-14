import 'package:get/get.dart';

import 'components/todo_board/controller.dart';

class TeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TodoBoardController());
  }
}
