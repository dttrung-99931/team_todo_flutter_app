import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../base/base_get_widget.dart';
import '../../../constants/sizes.dart';
import '../../../constants/styles.dart';
import '../../notification/components/list.dart';
import '../../notification/controller.dart';

class RecentActions extends BaseGetWidget<NotificationController> {
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
        Obx(() => buildLoadingObx(
            NotificationList(
              notifications: controller.notifications,
            ),
          )),
      ],
    );
  }
}
