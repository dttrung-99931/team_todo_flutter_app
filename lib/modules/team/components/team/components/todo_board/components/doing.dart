import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../../../base/base_get_widget.dart';
import '../../../../../../../base/on_item_clicked.dart';
import 'task/list.dart';
import 'task/model.dart';
import '../controller.dart';
import 'upsert_task_dialog.dart';

class Doing extends BaseGetWidget<TodoBoardController> {
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Obx(() => TaskList(
              onTaskEdited: onTaskEdited,
              tasks: controller.doingTasks,
              onItemMovedLeft: (task) {
                controller.moveTask(task, 1, 0);
              },
              onItemMovedRight: (task) {
                controller.moveTask(task, 1, 2);
              },
            )));
  }

  onTaskEdited(TaskModel task, EditAction action) {
    if (action == EditAction.Update) {
      Get.dialog(UpsertTaskDialog(
        taskToUpdate: task,
        boardIndex: 1,
      ));
    } else if (action == EditAction.Delete) {
      showAlertDialog('Delete task ${task.title}', () {
        controller.deleteTask(task.id, 1);
      });
    }
  }
}
