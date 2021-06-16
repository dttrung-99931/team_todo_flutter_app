import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/task_model.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;

  const TaskList({
    @required this.tasks,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tasks.length != 0
        ? ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TodoItem(index, tasks[index]);
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
  final int index;
  final TaskModel task;
  const TodoItem(
    this.index,
    this.task, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text('Start at ${formatDate(task.startDate)}'),
      leading: CircleAvatar(
        backgroundColor: kPrimarySwatch,
      ),
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.fromLTRB(
        kDefaultPadding * 1.5,
        0,
        0,
        0,
      ),
      trailing: Container(
        child: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}
