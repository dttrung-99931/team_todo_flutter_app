import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/utils/constants.dart';

class BadgeWidget extends StatelessWidget {
  final Widget child; // child
  final int badgeNumber; // badge number
  final double elevation; // elevation
  final bool hidebadgeIfZeroNumber; // hide badge on zero badge number
  final Color badgeTextColor; // badge color

  const BadgeWidget({
    @required this.badgeNumber,
    this.elevation = 2,
    this.child,
    this.hidebadgeIfZeroNumber = true,
    this.badgeTextColor = kPrimarySwatch,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Text(
        badgeNumber.toString(),
        style: TextStyle(color: badgeTextColor),
      ),
      elevation: elevation,
      badgeColor: Colors.white,
      child: child,
      showBadge: (badgeNumber != 0) || !hidebadgeIfZeroNumber,
    );
  }
}
