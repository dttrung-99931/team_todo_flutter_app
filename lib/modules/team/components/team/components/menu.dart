import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/routes.dart';
import 'package:team_todo_app/widgets/menu_item.dart';

import '../../../../../base/base_get_widget.dart';
import '../../../../../widgets/badge_widget.dart';
import '../../../controller.dart';

class TeamMenu extends BaseGetWidget<TeamController> {
  TeamMenu({Key key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: controller.isTeamOwner()
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center,
            children: buildTeamMenuItems(),
          ),
        ],
      ),
    );
  }

  List<Widget> buildTeamMenuItems() {
    List<Widget> items = [
      MenuItem(
        title: "Members",
        child: Obx(
          () => BadgeWidget(
            badgeNumber: controller.selectedTeam.userIDs.length,
            child: buildMenuIcon(Icons.people_outlined),
          ),
        ),
        onTap: () {
          toNamedRelative(RouteNames.MEMBERS);
        },
        titleFontSize: FontSizes.s14,
      ),
      MenuItem(
        title: "Actions",
        child: Obx(
          () => BadgeWidget(
            badgeNumber: controller.newActionIDs.length,
            child: buildMenuIcon(Icons.history_outlined),
          ),
        ),
        onTap: () {
          toNamedRelative(RouteNames.ACTIONS);
        },
        titleFontSize: FontSizes.s14,
      ),
    ];
    if (controller.isTeamOwner()) {
      items.add(
        MenuItem(
          title: "Join requests",
          child: Obx(
            () => BadgeWidget(
              badgeNumber: controller.selectedTeam.pendingUserIDs.length,
              child: buildMenuIcon(Icons.person_add_alt_1_outlined),
            ),
          ),
          onTap: () {
            toNamedRelative(RouteNames.JOIN_REQUEST, arguments: controller.selectedTeam);
          },
          titleFontSize: FontSizes.s14,
        ),
      );
    }
    return items;
  }

  Widget buildMenuIcon(IconData iconData) {
    return Icon(
      iconData,
      size: 36,
    );
  }
}
