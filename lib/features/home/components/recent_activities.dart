import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/utils/constants.dart';

import '../home_controller.dart';
import 'recent_activity_list.dart';

class RecentActivities extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding, bottom: 1),
            child: Text("Recent activities",
                style: Theme.of(context).textTheme.headline6)),
        Column(
          children: [
            Container(height: 320, child: RecentActivityList()),
            Text('...')
          ],
        )
      ],
    );
  }
}
