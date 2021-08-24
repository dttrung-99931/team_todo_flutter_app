import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'menu.dart';
import 'notifications.dart';

class Body extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Menu(),
        SizedBox(
          height: 10,
        ),
        RecentActions(),
      ],
    ),);
  }
}
