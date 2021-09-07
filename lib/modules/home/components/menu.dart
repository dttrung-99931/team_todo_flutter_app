import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../base/base_get_widget.dart';
import '../../../constants/sizes.dart';
import '../../notification/controller.dart';
import '../../../widgets/badge.dart';
import '../../../widgets/menu_item.dart';

class Menu extends BaseGetWidget<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildMenuItem("Teams", Icons.group_outlined, () async {
                // Test handling error
                // throw Exception('Error from home menu');
                await Get.toNamed('/teams');
                // Reload notis each time home navigating back to home screen
                controller.loadNotis();
              }),
              buildMenuItem("Tasks", Icons.event_note_outlined, () {}),
              buildMenuItem("My notes", Icons.note_outlined, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(String title, IconData iconData, Function onTap,
      [int badgeNum = 0]) {
    return MenuItem(
      // isBold: true,
      title: title,
      child: BadgeWidget(
        badgeNumber: badgeNum,
        child: Icon(iconData, size: Sizes.s44),
        hidebadgeIfZeroNumber: true,
      ),
      onTap: onTap,
      size: Sizes.s96,
    );
  }
}
