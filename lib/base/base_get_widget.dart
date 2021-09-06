import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/utils/ui_utils.dart';

import 'base_controller.dart';

abstract class BaseGetWidget<TController extends BaseController>
    extends GetWidget<TController> {
  /// Build widget that is progress bar if [controller.isLoading] is true
  /// otherwise [child]
  Obx buildLoadingObx(Widget child) {
    return Obx(() => controller.isLoading ? buildCenterProgressBar() : child);
  }

  Widget buildCenterProgressBar() {
    return UIUtils.buildCenterProgressBar();
  }

  CircularProgressIndicator buildProgressBar() {
    return UIUtils.buildProgressBar();
  }

  Future<void> showAlertDialog(String alertMsg, Function onYes) async {
    var alertDialog = AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("NO"),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            onYes();
          },
          child: Text("YES"),
        ),
      ],
      title: Text(alertMsg),
    );
    await Get.dialog(alertDialog);
  }

  // Navigate to a route relatively
  void toNamedRelative(String routeName, {dynamic arguments}) {
    if (Get.currentRoute != '/') {
      Get.toNamed(Get.currentRoute + routeName, arguments: arguments);
    } else {
      Get.toNamed(routeName, arguments: arguments);
    }
  }
}
