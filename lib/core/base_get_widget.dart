import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';

abstract class BaseGetWidget<TController extends BaseController>
    extends GetWidget<TController> {
  ///
  /// Build widget that is compounded with progress bar
  /// if [controller.isLoading] true, then the widget is progress bar
  /// otherwise it's [child]
  ///
  Obx buildFutureWidget(Widget child) {
    return Obx(() => controller.isLoading ? buildProgressBar() : child);
  }

  Widget buildProgressBar() {
    return Center(
      child: Container(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
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
          onPressed: () async {
            await onYes();
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
