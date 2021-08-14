import 'package:get/get.dart';

import 'components/todo_board/components/task/service.dart';
import 'components/todo_board/controller.dart';

class TeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskService());
    Get.put(TodoBoardController());
  }
}
