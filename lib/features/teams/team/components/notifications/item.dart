import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/features/teams/action_model.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

class TeamNotificationItem extends StatelessWidget {
  final ActionModel item;
  final Function(ActionModel item) onPress;

  TeamNotificationItem({
    @required this.item,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: 8,
        top: 8,
        right: 8,
        bottom: 0,
      ),
      child: Container(
        child: ListTile(
          title: Text(
            item?.task?.title ?? "",
            style: TextStyle(fontSize: 17),
          ),
          subtitle: Text(formatDate(item.date, true)),
          leading: Icon(item.getIconActionType(), color: kPrimarySwatch),
        ),
      ),
    );
  }
}
