import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/base/base_get_widget.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/modules/team/components/upsert_team_dialog.dart';
import 'package:team_todo_app/modules/teams/model.dart';
import 'package:team_todo_app/widgets/listview_widget.dart';

import '../../controller.dart';
import 'item.dart';

class MyTeams extends BaseGetWidget<TeamController> {
  final Function(TeamModel team) onTeamSelected;

  MyTeams({this.onTeamSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My teams',
              style: Styles.subtitle,
            ),
            IconButton(
              icon: Icon(Icons.add, size: Sizes.s16),
              padding: EdgeInsets.all(Sizes.s4),
              color: Colors.purple,
              onPressed: () {
                Navigator.of(context).pop();
                Get.dialog(UpsertTeamDialog());
              },
            )
          ],
        ),
        ListViewWidget(
          shrinkWrap: true,
          children: controller.myTeams
              .map(
                (e) => MyTeamItem(
                  team: e,
                  onPressed: () {
                    controller.selectTeam(e);
                    onTeamSelected?.call(e);
                  },
                  isSelected: controller.selectedTeam.id == e.id
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
