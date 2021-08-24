import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/modules/notification/components/list.dart';
import 'package:team_todo_app/modules/notification/controller.dart';

class RecentActions extends GetWidget<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: Sizes.s8, bottom: Sizes.s4),
          child: Text(
            "Notifications",
            style: Styles.textTitle.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Obx(
          () => NotificationList(
            notifications: controller.notifications,
          ),
        ),
      ],
    );
  }
}
