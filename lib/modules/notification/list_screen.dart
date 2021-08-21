import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/widgets/listview_widget.dart';

import '../../base/base_get_widget.dart';
import 'controller.dart';
import 'item.dart';

class NotificationListScreen extends BaseGetWidget<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(() {
        return buildFutureWidget(ListViewWidget(
          noDataTitle: 'No notifications',
          children: controller.notifications
              .map(
                (noti) => NotificationItem(
                  item: noti,
                  onPress: (item) {},
                ),
              )
              .toList(),
        ));
      }),
      appBar: _buildAppBar(),
    ));
  }

  Widget _buildAppBar() {
    return AppBar(
      // backgroundColor: Colors.white,
      title: Text('Notifications', style: TextStyle(color: Colors.white)),
    );
  }
}
