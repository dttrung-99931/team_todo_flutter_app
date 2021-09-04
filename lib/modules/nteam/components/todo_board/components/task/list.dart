import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/widgets/character_avatar.dart';

import '../../../../../../base/on_item_clicked.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../utils/utils.dart';
import 'model.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(TaskModel task) onItemMovedLeft, onItemMovedRight;
  final String moveLeftTitle, moveRightTitle;
  final OnItemEdited<TaskModel> onTaskEdited;

  const TaskList({
    @required this.tasks,
    this.moveLeftTitle,
    this.moveRightTitle,
    this.onItemMovedLeft,
    this.onItemMovedRight,
    this.onTaskEdited,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tasks.length != 0
        ? ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TodoItem(tasks[index], this);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
              );
            },
          )
        : Center(child: Text('No tasks'));
  }
}

class TodoItem extends StatelessWidget {
  final TaskModel task;
  final TaskList taskList;

  const TodoItem(this.task, this.taskList);

  @override
  Widget build(BuildContext context) {
    final email = task.assigneeUser?.email ?? '';
    return Dismissible(
      direction: getDismissDirection(),
      onDismissed: onDismissed,
      background: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: List.generate(
            4,
            (index) => Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
        ),
      ),
      secondaryBackground: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            4,
            (index) => Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
        ),
      ),
      key: Key(task.id),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text('Start at ${formatDate(task.startDate)}'),
        leading: CharacterAvatar(name: email),
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.fromLTRB(
          kDefaultPadding * 1.5,
          0,
          0,
          0,
        ),
        trailing: buildOptionBtn(),
      ),
    );
  }

  Widget buildOptionBtn() {
    return PopupMenuButton<EditAction>(
        child: Container(
          margin: const EdgeInsets.only(right: 6),
          child: Icon(Icons.more_vert),
        ),
        onSelected: (value) {
          if (taskList.onTaskEdited != null) {
            this.taskList.onTaskEdited(task, value);
          }
        },
        itemBuilder: (context) => [
              PopupMenuItem<EditAction>(
                  value: EditAction.Update, child: Text('Update task')),
              PopupMenuItem<EditAction>(
                  value: EditAction.Delete,
                  child:
                      Text('Delete task', style: TextStyle(color: Colors.red))),
            ]);
  }

  DismissDirection getDismissDirection() {
    if (taskList.onItemMovedLeft != null && taskList.onItemMovedRight != null) {
      return DismissDirection.horizontal;
    }
    if (taskList.onItemMovedLeft != null) {
      return DismissDirection.endToStart;
    }
    if (taskList.onItemMovedRight != null) {
      return DismissDirection.startToEnd;
    }
    return DismissDirection.none;
  }

  void onDismissed(DismissDirection direction) {
    if (taskList.onItemMovedLeft != null &&
        direction == DismissDirection.endToStart) {
      taskList.onItemMovedLeft(task);
    } else if (taskList.onItemMovedRight != null &&
        direction == DismissDirection.startToEnd) {
      taskList.onItemMovedRight(task);
    }
  }
}

