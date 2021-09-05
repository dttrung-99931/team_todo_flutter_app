import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../base/base_get_widget.dart';
import '../../../../team/components/team_search/controller.dart';
import '../../../model.dart';
import '../../../../team/components/team_preview/controller.dart';

class HeaderAppBar extends BaseGetWidget<TeamPreviewController> {
  final double height;
  final TeamModel team;

  HeaderAppBar({
    @required this.height,
    @required this.team,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        background: Placeholder(),
      ),
      expandedHeight: height,
      title: Text(team.name),
      pinned: true,
      actions: [_buildDropDownOptionBtn2()],
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

  final int ID_ITEM_JOIN_TEAM = 4;

  List<PopupMenuItem> _buildPopupMenuItem(BuildContext context) {
    return [
      PopupMenuItem(
          value: ID_ITEM_JOIN_TEAM, child: buildFutureWidget(Text('Join team')))
    ];
  }

  final _teamExploreController = Get.find<TeamSearchController>();

  Future<void> _onMenuItemSelected(int menuID) async {
    if (menuID == ID_ITEM_JOIN_TEAM) {
      await controller.jointTeam(team.id);
      _teamExploreController.loadSuggestTeams();
    }
  }
}
