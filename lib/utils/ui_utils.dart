import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import 'package:team_todo_app/modules/home/components/drawer_menu.dart';

class UIUtils {
  static Widget buildCenterProgressBar() {
    return Center(
      child: buildProgressBar(),
    );
  }

  static Widget buildProgressBar() {
    return Container(
      width: Sizes.s24,
      height: Sizes.s24,
      padding: EdgeInsets.all(Sizes.s4),
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 2,
      ),
    );
  }

  static Widget buildErrorwidget(String msg) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(Sizes.s16),
          margin: const EdgeInsets.all(Sizes.s16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(-Sizes.s4, Sizes.s4),
                color: Colors.grey[400],
                blurRadius: Sizes.s4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'OPPS',
                style: TextStyle(
                  color: kPrimarySwatch,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSizes.s20,
                ),
              ),
              SizedBox(height: Sizes.s8),
              Text(
                'Something went wrong',
                style: Styles.textTitle.copyWith(
                  color: kPrimarySwatch[800],
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Sizes.s16),
              Padding(
                padding: const EdgeInsets.only(right: Sizes.s8),
                child: ComposedButtonWidget(
                  color: Colors.grey,
                  expanded: false,
                  iconData: Icons.keyboard_arrow_left,
                  title: 'Back',
                  onPressed: () {
                    Get.back();
                  },
                  iconAndTitleSpace: Sizes.s4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
