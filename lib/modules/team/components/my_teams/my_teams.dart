import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/base/base_get_widget.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/modules/team/components/upsert_team_dialog.dart';
import 'package:team_todo_app/modules/team/model.dart';
import 'package:team_todo_app/widgets/icon_button.dart';
import 'package:team_todo_app/widgets/listview.dart';

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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: Sizes.s4),
                Icon(Icons.group, size: Sizes.s20),
                SizedBox(width: Sizes.s8),
                Text(
                  'My teams',
                  style: Styles.textTitle.copyWith(color: kPrimarySwatch),
                ),
              ],
            ),
            IconButtonWidget(
              iconData: Icons.add,
              onPressed: () {
                Get.dialog(UpsertTeamDialog());
              },
              size: Sizes.s20,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Obx(() {
            return ListViewWidget(
              shrinkWrap: true,
              isInScrollView: true,
              children: controller.myTeams
                  .map(
                    (e) => MyTeamItem(
                        team: e,
                        onPressed: () {
                          controller.selectTeam(e);
                          onTeamSelected?.call(e);
                        },
                        isSelected: controller.selectedTeam.id == e.id),
                  )
                  .toList(),
            );
          }),
        ),
      ],
    );
  }
}
