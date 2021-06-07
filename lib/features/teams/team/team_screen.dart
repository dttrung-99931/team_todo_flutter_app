import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/team_model.dart';

import '../teams_controller.dart';
import 'components/body.dart';

class TeamScreen extends BaseGetWidget<TeamsController> {
  TeamModel get team => Get.arguments as TeamModel;

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
  final int ID_ITEM_PH_2 = 2;
  final int ID_ITEM_PH_3 = 2;

  List<PopupMenuItem> _buildPopupMenuItem(BuildContext context) {
    return [
      PopupMenuItem(
        value: ID_ITEM_DELETE_TEAM,
        child: Text('Delete team'),
      ),
      PopupMenuItem(
        value: ID_ITEM_PH_2,
        child: Text('Place holder 2'),
      ),
      PopupMenuItem(
        value: ID_ITEM_PH_2,
        child: Text('Place holder 3'),
      )
    ];
  }

  Future<void> _showDeleteTeamAlert() async {
    await showAlertDialog('Delete team?', () {});
  }

  Future<void> _onMenuItemSelected(int menuID) async {
    if (menuID == ID_ITEM_DELETE_TEAM) {
      await _showDeleteTeamAlert();
    }
  }
}
