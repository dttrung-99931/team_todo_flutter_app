import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/utils/utils.dart';

import '../model.dart';

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
        top: 0,
        right: Sizes.s8,
        bottom: Sizes.s8,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.s8,
          horizontal: Sizes.s16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: Sizes.s4),
              child: Icon(Icons.event_note_outlined),
            ),
            SizedBox(width: Sizes.s16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.action?.user?.email ?? "",
                    // "Title",
                    style: Styles.textTitle.copyWith(fontSize: FontSizes.s16),
                  ),
                  SizedBox(
                    height: Sizes.s4,
                  ),
                  Text(
                    item?.action?.actionDisplay() ?? "",
                    style: Styles.subtitle,
                  ),
                  SizedBox(
                    height: Sizes.s4,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatDate(item.date, true),
                      style: Styles.subtitle.copyWith(fontSize: FontSizes.s12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
