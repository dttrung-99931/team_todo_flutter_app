import 'package:flutter/material.dart';
import 'package:team_todo_app/constants/sizes.dart';

class UIUtils {
  static Widget buildCenterProgressBar() {
    return Center(
      child: Container(
        width: Sizes.s24,
        height: Sizes.s24,
        padding: EdgeInsets.all(Sizes.s4),
        child: buildProgressBar(),
      ),
    );
  }

  static CircularProgressIndicator buildProgressBar() {
    return CircularProgressIndicator(
      backgroundColor: Colors.white,
      strokeWidth: 2,
    );
  }
}
