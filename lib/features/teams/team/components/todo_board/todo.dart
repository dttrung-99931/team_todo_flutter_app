import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/todo_board_controller.dart';

import 'task_list.dart';

class Todo extends BaseGetWidget<TodoBoardController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Obx(() => TaskList(
              tasks: controller.todoTasks,
            )));
  }
}
