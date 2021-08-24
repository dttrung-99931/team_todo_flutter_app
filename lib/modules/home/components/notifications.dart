import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/modules/notification/components/list.dart';
import 'package:team_todo_app/modules/notification/controller.dart';

import '../../../constants/constants.dart';

class RecentActions extends GetWidget<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding, bottom: 1),
          child: Text("Notifications",
              style: Theme.of(context).textTheme.headline6),
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
