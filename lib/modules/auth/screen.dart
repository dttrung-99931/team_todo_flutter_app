import 'package:flutter/material.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/widgets/language_switch.dart';

import '../../constants/constants.dart';
import 'components/body.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Body(),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          LanguageSwitch(),
          SizedBox(
            width: Sizes.s16,
          )
        ],
        elevation: 0,
        backgroundColor: kPrimarySwatch[400],
      )
      // Align(alignment: Alignment.centerRight, child: LanguageSwitch()),
      ,
      backgroundColor: kPrimarySwatch[400],
      resizeToAvoidBottomInset: true,
    );
  }
}
