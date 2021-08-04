import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_get_widget.dart';
import 'controller.dart';

class NotificationListScreen extends BaseGetWidget<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(() {
        return ListView(
          children: controller.notifications
              .map(
                (noti) => Card(
                  child: ListTile(title: Text(noti.id)),
                ),
              )
              .toList(),
        );
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
