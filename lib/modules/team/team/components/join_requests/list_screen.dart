import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../base/base_get_widget.dart';
import 'controller.dart';
import 'components/list.dart';

class JoinRequestScreen extends BaseGetWidget<JoinRequestController> {
  JoinRequestScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Join requests'),
        ),
        body: Obx(() => controller.joinRequests.length != 0
            ? JoinRequestList(
                joinRequests: controller.joinRequests,
                onRequestConfirmed: (request, isAccepted) async {
                  await controller.onRequestConfirmed(request, isAccepted);
                },
              )
            : Center(
                child: Text('No requests'),
              )),
      ),
    );
  }
}
