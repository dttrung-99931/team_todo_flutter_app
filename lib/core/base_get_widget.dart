import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseGetWidget<TController extends GetLifeCycleBase>
    extends GetWidget<TController> {
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
}
