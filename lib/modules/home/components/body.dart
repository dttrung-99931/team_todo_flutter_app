import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/sizes.dart';

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
            height: Sizes.s4,
          ),
          Menu(),
          SizedBox(
            height: Sizes.s8,
          ),
          RecentActions(),
        ],
      ),
    );
  }
}
