import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/components/team_list.dart';

import 'team_explore_controller.dart';

class TeamExplore extends BaseGetWidget<TeamExploreController> {
  @override
  Widget build(BuildContext context) {
    return buildFutureWidget(Obx(
      () => TeamList(
        teams: controller.teams,
        onTeamSelected: (team) async {
          await Get.toNamed('/team-preview', arguments: team);
        },
      ),
    ));
  }
}
