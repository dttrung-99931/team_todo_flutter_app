import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:team_todo_app/features/teams/team_model.dart';
import 'package:team_todo_app/features/teams/teams_controller.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

import 'team_item.dart';

class TeamList extends GetWidget<TeamsController> {
  const TeamList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => controller.isLoading ? _buildProgressBar() : _buildTeamList());
  }

  Widget _buildProgressBar() {
    return Center(
      child: Container(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildTeamList() {
    return Obx(() => controller.myTeams.length != 0
        ? ListView(
            children: controller.myTeams.map((e) => TeamItem(e)).toList(),
          )
        : Center(
            child: Text('No teams'),
          ));
  }
}
