import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/translation/app_translation.dart';

class LanguageSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildLanguageBtn(
            languageShort: 'EN',
            onPressed: () {
              AppTranslation.changeLanguage(AppTranslation.LANG_CODE_EN);
            },
            color: AppTranslation.currentLanguage == AppTranslation.LANG_EN
                ? kPrimarySwatch
                : Colors.grey[400],
            roundLeft: true,
          ),
          buildLanguageBtn(
            languageShort: 'VI',
            onPressed: () {
              AppTranslation.changeLanguage(AppTranslation.LANG_CODE_VI);
            },
            color: AppTranslation.currentLanguage == AppTranslation.LANG_VI
                ? kPrimarySwatch
                : Colors.grey[400],
            roundRight: true,
          ),
        ],
      );
    });
  }

  Widget buildLanguageBtn({
    @required String languageShort,
    @required Function onPressed,
    @required Color color,
    bool roundLeft = false,
    bool roundRight = false,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.s2,
          horizontal: Sizes.s8,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(roundLeft ? Sizes.s8 : 0),
            right: Radius.circular(roundRight ? Sizes.s8 : 0),
          ),
          border: Border.all(color: Colors.black26),
        ),
        child: Text(
          languageShort,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
