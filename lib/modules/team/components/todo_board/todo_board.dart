import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../base/base_get_widget.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/badge.dart';
import 'components/doing.dart';
import 'components/finish.dart';
import 'components/todo.dart';
import 'controller.dart';
import 'components/upsert_task_dialog.dart';

class TodoBoard extends BaseGetWidget<TodoBoardController> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              floatingActionButton: buildAddTaskFAB(),
              body: buildTodoBoard(),
            )),
      ),
    );
  }

  FloatingActionButton buildAddTaskFAB() {
    return FloatingActionButton(
      mini: true,
      onPressed: () {
        Get.dialog(UpsertTaskDialog());
      },
      child: Icon(Icons.add),
    );
  }

  Column buildTodoBoard() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(tabs: [
            Obx(
              () => buildTabWithBadge('Todo', controller.todoTasks.length),
            ),
            Obx(
              () => buildTabWithBadge('Doing', controller.doingTasks.length),
            ),
            Obx(
              () => buildTabWithBadge('Finish', controller.finishTasks.length),
            ),
          ], labelColor: Colors.black),
        ),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        Expanded(
          child: TabBarView(children: [
            Todo(),
            Doing(),
            Finish(),
          ]),
        )
      ],
    );
  }

  Tab buildTabWithBadge(String title, int badgeNumber) {
    return Tab(
      child: BadgeWidget(
        badgeNumber: badgeNumber,
        child: Padding(
          padding: const EdgeInsets.only(right: kDefaultPadding),
          child: Text(title),
        ),
        hidebadgeIfZeroNumber: false,
        elevation: 1,
      ),
    );
  }
}
