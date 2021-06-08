import 'package:get/get.dart';

import 'team_exploration/team_explore_controller.dart';
import 'team_preview/team_preview_controller.dart';
import 'teams_controller.dart';
import 'teams_service.dart';

class TeamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamsService());
    Get.put(TeamsController());
    Get.lazyPut(() => TeamExploreController());
    Get.lazyPut(() => TeamPreviewController());
  }
}
