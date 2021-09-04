import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/listview_widget.dart';

import '../../../../base/base_get_widget.dart';
import 'controller.dart';
import 'item.dart';

class TeamActionListScreen extends BaseGetWidget<TeamActionController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Actions'),
        ),
        body: Obx(() => buildFutureWidget(
              ListViewWidget(
                children: controller.actions
                    .map(
                      (e) => TeamActionItem(
                        onPress: (item) {},
                        item: e,
                      ),
                    )
                    .toList(),
              ),
            )),
      ),
    );
  }
}
