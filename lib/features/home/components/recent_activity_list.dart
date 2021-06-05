import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/utils/constants.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => RecentActivityItem(),
      itemCount: 5,
    );
  }
}

class RecentActivityItem extends StatelessWidget {
  const RecentActivityItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(
          kDefaultPadding, kDefaultPadding, kDefaultPadding, 0),
      child: ListTile(
        leading: Icon(
          Icons.history_outlined,
          color: kPrimarySwatch,
        ),
        minLeadingWidth: 0,
        title: Text("Add a new member"),
        trailing: Text(
          '20/10/2020',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
