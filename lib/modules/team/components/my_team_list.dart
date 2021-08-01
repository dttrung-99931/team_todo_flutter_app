import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../base/base_get_widget.dart';
import '../controller.dart';
import 'list.dart';
import 'upsert_team_dialog.dart';

class MyTeamList extends BaseGetWidget<TeamController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        body: buildFutureWidget(Obx(
          () => TeamList(
            teams: controller.myTeams,
            onTeamSelected: (team) {
              controller.selectTeam(team);
              Get.toNamed('/team', arguments: team);
            },
          ),
        )));
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.dialog(UpsertTeamDialog());
        });
  }
}
