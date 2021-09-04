import 'package:flutter/material.dart';
import '../../../widgets/listview_widget.dart';

import '../model.dart';
import 'item.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    Key key,
    @required this.notifications,
  }) : super(key: key);

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return ListViewWidget(
      noDataTitle: 'No notifications',
      shrinkWrap: true,
      isInScrollView: true,
      children: notifications
          .map(
            (noti) => NotificationItem(
              item: noti,
              onPress: (item) {},
            ),
          )
          .toList(),
    );
  }
}
