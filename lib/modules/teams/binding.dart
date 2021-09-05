import 'package:get/get.dart';

import '../team/components/actions/service.dart';
import '../team/components/join_requests/controller.dart';
import '../team/components/team_search/controller.dart';
import '../team/components/team_preview/controller.dart';
import '../team/controller.dart';

class TeamListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ActionService());
    Get.put(TeamController());

    /// @FIXME these below controller should be put lazily
    /// but it will cause controller not found exception in TeamScreen
    Get.put(TeamSearchController());
    Get.put(TeamPreviewController());

    Get.lazyPut(() => JoinRequestController());

// Get.lazyPut(() => TeamExploreController());
//     Get.lazyPut(() => TeamPreviewController());
  }
}
