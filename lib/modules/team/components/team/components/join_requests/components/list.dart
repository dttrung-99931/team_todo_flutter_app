import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../../constants/constants.dart';
import '../model.dart';

class JoinRequestList extends StatelessWidget {
  final Function(JoinRequestModel request, bool isAccepted) onRequestConfirmed;
  const JoinRequestList({
    Key key,
    @required this.joinRequests,
    this.onRequestConfirmed,
  }) : super(key: key);

  final List<JoinRequestModel> joinRequests;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: joinRequests
          .map((request) => Card(
              child: JoinRequestItem(request,
                  onRequestConfirmed: onRequestConfirmed)))
          .toList(),
    );
  }
}

class JoinRequestItem extends StatelessWidget {
  final JoinRequestModel joinRequest;
  final Function(JoinRequestModel, bool) onRequestConfirmed;

  const JoinRequestItem(
    this.joinRequest, {
    this.onRequestConfirmed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = joinRequest.requestDate;
    final formattedDate = '${date.day}/${date.month}/${date.year}';
    var textTheme = Theme.of(context).textTheme;
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 2,
        vertical: kDefaultPadding,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${joinRequest.email}',
            style: textTheme.bodyText1.copyWith(fontSize: 18),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            formattedDate,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                onRequestConfirmed(joinRequest, false);
              },
              child: Text(
                'Decline',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                onRequestConfirmed(joinRequest, true);
              },
              child: Text('Accept'),
            ),
          ],
        ),
      ],
    );
  }
}
