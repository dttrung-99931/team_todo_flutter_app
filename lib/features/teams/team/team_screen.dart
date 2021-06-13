import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/components/upsert_team_dialog.dart';
import 'package:team_todo_app/features/teams/team_exploration/team_explore_controller.dart';

import '../teams_controller.dart';
import 'components/body.dart';

class TeamScreen extends BaseGetWidget<TeamsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.selectedTeam.name),
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
      itemBuilder: (BuildContext context) {
        final isTeamOwner = controller.isTeamOwner();
        return isTeamOwner
            ? _buildPopupMenuItemsForOwner(context)
            : _buildPopupMenuItemsForMember(context);
      },
    );
  }

  final int ID_ITEM_DELETE_TEAM = 1;
  final int ID_ITEM_UPDATE_TEAM = 2;
  final int ID_ITEM_UNJOIN_TEAM = 3;

  List<PopupMenuItem> _buildPopupMenuItemsForOwner(BuildContext context) {
    return [
      PopupMenuItem(
        value: ID_ITEM_DELETE_TEAM,
        child: Text('Delete team'),
      ),
      PopupMenuItem(
        value: ID_ITEM_UPDATE_TEAM,
        child: Text('Update team'),
      ),
    ];
  }

  List<PopupMenuItem> _buildPopupMenuItemsForMember(BuildContext context) {
    return [
      PopupMenuItem(
        value: ID_ITEM_UNJOIN_TEAM,
        child: Text('Unjoin team'),
      ),
    ];
  }

  Future<void> _onMenuItemSelected(int menuItenID) async {
    if (menuItenID == ID_ITEM_DELETE_TEAM) {
      await _showDeleteTeamAlert();
    } else if (menuItenID == ID_ITEM_UPDATE_TEAM) {
      await Get.dialog(UpsertTeamDialog(
        teamModel: controller.selectedTeam,
      ));
    } else if (menuItenID == ID_ITEM_UNJOIN_TEAM) {
      await _showUnjoinTeamAlert();
    }
  }

  Future<void> _showDeleteTeamAlert() async {
    await showAlertDialog('Delete team?', () async {
      await controller.delete(controller.selectedTeam.id);
      Get.back();
    });
  }

  final _teamExploreController = Get.find<TeamExploreController>();

  Future<void> _showUnjoinTeamAlert() async {
    await showAlertDialog('Unjoin team?', () async {
      await controller.unjoinAppUserFromTeam(controller.selectedTeam.id);
      Get.back();
      _teamExploreController.loadSuggestTeams();
    });
  }
}
