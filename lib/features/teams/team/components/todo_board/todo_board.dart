import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/todo_board_controller.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/upsert_task_dialog.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/finish.dart';
import 'package:team_todo_app/utils/constants.dart';

import 'doing.dart';
import 'todo.dart';

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
            Tab(child: Text('Todo')),
            Tab(child: Text('Doing')),
            Tab(child: Text('Finish')),
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
}
