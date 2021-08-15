import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/utils/utils.dart';

import 'model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel item;
  final Function(NotificationModel item) onPress;

  NotificationItem({
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
          dense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizes.s16,
            vertical: Sizes.s8,
          ),
          title: Text(
            item?.action?.user?.email ?? "",
            // "Title",
            style: Styles.textTitle,
          ),
          leading: Text(
            item.typeDisplay(),
            style: Styles.textTitle,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.s8),
                child: Text(
                  item?.action?.actionDisplay() ?? "",
                  style: Styles.normal,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatDate(item.date, true),
                  style: Styles.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
