import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

abstract class BaseGetWidget<TController extends BaseController>
    extends GetWidget<TController> {

  /// Build widget that is progress bar if [controller.isLoading] is true
  /// otherwise [child]
  Obx buildFutureWidget(Widget child) {
    return Obx(() => controller.isLoading ? buildProgressBar() : child);
  }

  Widget buildProgressBar() {
    return Center(
      child: Container(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 2,
        ),
      ),
    );
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
            onYes();
            Get.back();
          },
          child: Text("YES"),
        ),
      ],
      title: Text(alertMsg),
    );
    await Get.dialog(alertDialog);
  }
}
