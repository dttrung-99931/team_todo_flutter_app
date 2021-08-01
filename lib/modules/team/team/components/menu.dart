import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../base/base_get_widget.dart';
import '../../../../widgets/badge_widget.dart';
import '../../controller.dart';

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
      buildMenuItem(
        title: "Members",
        child: Obx(
          () => BadgeWidget(
            badgeNumber: controller.selectedTeam.userIDs.length,
            child: buildMenuIcon(Icons.people_outlined),
          ),
        ),
        onTap: () {
          Get.toNamed('/teams/team/members');
        },
      ),
      buildMenuItem(
        title: "Notifications",
        child: Obx(
          () => BadgeWidget(
            badgeNumber: controller.newTeamActionIDs.length,
            child: buildMenuIcon(Icons.notifications_outlined),
          ),
        ),
        onTap: () {
          Get.toNamed('/teams/team/notifications');
        },
      ),
    ];
    if (controller.isTeamOwner()) {
      items.add(
        buildMenuItem(
          title: "Join requests",
          child: Obx(
            () => BadgeWidget(
              badgeNumber: controller.selectedTeam.pendingUserIDs.length,
              child: buildMenuIcon(Icons.person_add_alt_1_outlined),
            ),
          ),
          onTap: () {
            Get.toNamed('/teams/team/join-requests',
                arguments: controller.selectedTeam);
          },
        ),
      );
    }
    return items;
  }

  Widget buildMenuItem({String title, Widget child, Function onTap}) {
    return Card(
      elevation: 6,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: 96,
          height: 96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
              SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuIcon(IconData iconData) {
    return Icon(
      iconData,
      size: 36,
    );
  }
}
