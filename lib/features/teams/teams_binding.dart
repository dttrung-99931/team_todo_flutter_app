import 'package:get/get.dart';

import 'team/components/join_requests/join_request_controller.dart';
import 'team_exploration/team_explore_controller.dart';
import 'team_preview/team_preview_controller.dart';
import 'teams_controller.dart';
import 'teams_service.dart';

class TeamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamsService());
    Get.put(TeamsController());

    /// @FIXME these below controller should be put lazily
    /// but it will cause controller not found exception in TeamScreen
    Get.put(TeamExploreController());
    Get.put(TeamPreviewController());

    Get.lazyPut(() => JoinRequestController());

// Get.lazyPut(() => TeamExploreController());
//     Get.lazyPut(() => TeamPreviewController());
  }
}
