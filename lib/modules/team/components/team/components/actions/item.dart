import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';

import '../../../../../../constants/constants.dart';
import '../../../../../../utils/utils.dart';
import 'model.dart';

class TeamActivityItem extends StatelessWidget {
  final ActionModel item;
  final Function(ActionModel item) onPress;

  TeamActivityItem({
    @required this.item,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: Sizes.s8,
        top: Sizes.s8,
        right: Sizes.s8,
        bottom: 0,
      ),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          leading: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: Column(
              children: [
                Icon(
                  item.getIconActionType(),
                  color: kPrimarySwatch,
                  size: 28,
                ),
              ],
            ),
          ),
          minLeadingWidth: 0,
          title: Text(
            item?.task?.title ?? "ID ${item.taskID}",
            style: TextStyle(fontSize: 17),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  item?.user?.email ?? "unknown email",
                  style: Styles.normal.copyWith(
                    fontSize: FontSizes.s16,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    formatDate(item.date, true),
                    style: Styles.normal,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
