import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../constants/constants.dart';
import '../../../../../../utils/utils.dart';
import '../action/action_model.dart';

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
