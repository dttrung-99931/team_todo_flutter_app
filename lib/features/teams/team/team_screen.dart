import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/components/upsert_team_dialog.dart';
import 'package:team_todo_app/features/teams/team_model.dart';

import '../teams_controller.dart';
import 'components/body.dart';

class TeamScreen extends BaseGetWidget<TeamsController> {
  final TeamModel team = Get.arguments as TeamModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(team.name),
          actions: [_buildDropDownOptionBtn2()],
        ),
        body: Body(),
      ),
    );
  }

  Widget _buildDropDownOptionBtn2() {
    return PopupMenuButton(
      onSelected: (menuID) async {
        await _onMenuItemSelected(menuID);
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) => _buildPopupMenuItem(context),
    );
  }

  final int ID_ITEM_DELETE_TEAM = 1;
  final int ID_ITEM_UPDATE_TEAM = 2;
  final int ID_ITEM_PH_3 = 2;

  List<PopupMenuItem> _buildPopupMenuItem(BuildContext context) {
    return [
      PopupMenuItem(
        value: ID_ITEM_DELETE_TEAM,
        child: Text('Delete team'),
      ),
      PopupMenuItem(
        value: ID_ITEM_UPDATE_TEAM,
        child: Text('Update team'),
      ),
      PopupMenuItem(
        value: ID_ITEM_PH_3,
        child: Text('Place holder 3'),
      )
    ];
  }

  Future<void> _showDeleteTeamAlert() async {
    await showAlertDialog('Delete team?', () async {
      await controller.delete(team.id);
      Get.back();
    });
  }

  Future<void> _onMenuItemSelected(int menuID) async {
    if (menuID == ID_ITEM_DELETE_TEAM) {
      await _showDeleteTeamAlert();
    } else if (menuID == ID_ITEM_UPDATE_TEAM) {
      await Get.dialog(UpsertTeamDialog(
        teamModel: team,
      ));
    }
  }
}
