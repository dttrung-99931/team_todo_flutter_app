import 'package:flutter/material.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';

class MenuItem extends StatelessWidget {
  final Function onTap;
  final String title;
  final Widget child;
  final double size;
  final double titleFontSize;
  final bool isBold;

  const MenuItem({
    Key key,
    this.onTap,
    this.title,
    this.child,
    this.size = Sizes.s96,
    this.titleFontSize = Sizes.s16,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: size,
          height: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
              SizedBox(
                height: Sizes.s4,
              ),
              Text(
                title,
                style: Styles.textTitle.copyWith(
                  fontSize: titleFontSize,
                  fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
