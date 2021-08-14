import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../../../base/base_get_widget.dart';
import 'controller.dart';
import 'item.dart';

class TeamActivityListScreen extends BaseGetWidget<TeamActivityController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: Obx(() => buildFutureWidget(
              ListView(
                  children: controller.activities
                      .map(
                        (e) => TeamActivityItem(
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
