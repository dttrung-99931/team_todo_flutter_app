import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../base/base_get_widget.dart';
import '../list.dart';

import 'controller.dart';

class TeamExplore extends BaseGetWidget<TeamExploreController> {
  @override
  Widget build(BuildContext context) {
    return buildFutureWidget(Obx(
      () => TeamList(
        teams: controller.teams,
        onTeamSelected: (team) async {
          await Get.toNamed('/teams/team-preview', arguments: team);
        },
      ),
    ));
  }
}
