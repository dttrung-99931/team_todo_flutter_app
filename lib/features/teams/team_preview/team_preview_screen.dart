import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/team_model.dart';

import '../teams_controller.dart';
import 'components/body.dart';

class TeamPreviewScreen extends BaseGetWidget<TeamsController> {
  final TeamModel team = Get.arguments as TeamModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(team: team),
      ),
    );
  }
}
