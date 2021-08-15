import 'package:get/get.dart';

import 'components/team/components/actions/service.dart';
import 'components/team/components/join_requests/controller.dart';
import 'components/team_explore/controller.dart';
import 'components/team_preview/controller.dart';
import 'controller.dart';
import 'service.dart';

class TeamListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ActionService());
    Get.put(TeamService());
    Get.put(TeamController());

    /// @FIXME these below controller should be put lazily
    /// but it will cause controller not found exception in TeamScreen
    Get.put(TeamExploreController());
    Get.put(TeamPreviewController());

    Get.lazyPut(() => JoinRequestController());

// Get.lazyPut(() => TeamExploreController());
//     Get.lazyPut(() => TeamPreviewController());
  }
}
