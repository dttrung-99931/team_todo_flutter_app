import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../../base/base_get_widget.dart';
import 'controller.dart';
import 'components/item.dart';

class TeamNotificationsScreen
    extends BaseGetWidget<TeamNotificationsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: Obx(() => buildFutureWidget(
              ListView(
                  children: controller.newActions
                      .map(
                        (e) => TeamNotificationItem(
                          onPress: (item) {},
                          item: e,
                        ),
                      )
                      .toList()),
            )),
      ),
    );
  }
}
