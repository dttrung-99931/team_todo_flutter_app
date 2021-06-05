import 'package:flutter/material.dart';
import 'package:team_todo_app/features/auth/components/body.dart';
import 'package:team_todo_app/utils/constants.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Body()),
        ),
      ),
      backgroundColor: kPrimarySwatch[400],
      resizeToAvoidBottomInset: true,
    );
  }
}
