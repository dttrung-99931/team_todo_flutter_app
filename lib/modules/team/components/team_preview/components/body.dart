import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../teams/model.dart';

import 'header_app_bar.dart';

class Body extends StatelessWidget {
  final TeamModel team;
  const Body({
    Key key,
    this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        HeaderAppBar(team: team, height: size.height * 0.35),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => ListTile(
                  title: Text('Memeber 1'),
                )))
      ],
    );
  }
}
