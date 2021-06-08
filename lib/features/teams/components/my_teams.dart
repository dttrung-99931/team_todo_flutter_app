import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/components/upsert_team_dialog.dart';

import '../teams_controller.dart';
import 'team_list.dart';

class MyTeams extends BaseGetWidget<TeamsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        body: buildFutureWidget(Obx(
          () => TeamList(
            teams: controller.myTeams,
            onTeamSelected: (team) {
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
