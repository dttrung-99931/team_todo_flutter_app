import 'package:flutter/material.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/sizes.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final double size;
  final Color color;
  final EdgeInsets padding;
  const IconButtonWidget({
    @required this.iconData,
    this.onPressed,
    this.size = Sizes.s24,
    this.color = kPrimarySwatch,
    this.padding = const EdgeInsets.all(Sizes.s4),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: padding,
        child: Icon(iconData, size: size),
      ),
      onTap: onPressed,
    );
  }
}
