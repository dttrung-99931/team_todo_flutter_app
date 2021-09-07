import 'package:flutter/material.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';

/// Composed buttton with icon, title 
class ComposedButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final double iconSize;
  final Color color;
  final EdgeInsets padding;
  final String title;
  final bool expanded;
  final double iconAndTitleSpace;

  const ComposedButtonWidget({
    @required this.iconData,
    @required this.title,
    this.onPressed,
    this.iconSize = Sizes.s20,
    this.color = kPrimarySwatch,
    this.padding = const EdgeInsets.all(Sizes.s4),
    this.expanded = false,
    this.iconAndTitleSpace = Sizes.s8,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (iconData != null) Icon(iconData, size: iconSize),
            if (iconData != null) SizedBox(width: iconAndTitleSpace),
            Text(
              title,
              style: Styles.textTitle.copyWith(
                color: kPrimarySwatch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
