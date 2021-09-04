import 'package:get/get.dart';
import 'controller.dart';
import 'components/join_requests/controller.dart';
import 'components/todo_board/controller.dart';

class TeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamController());
    Get.lazyPut(() => JoinRequestController());
    Get.lazyPut(() => TodoBoardController());

    // Get.put(TeamExploreController());
    // Get.put(TeamPreviewController());
  }
}
