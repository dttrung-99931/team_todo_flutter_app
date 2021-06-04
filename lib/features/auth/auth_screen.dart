import 'package:flutter/material.dart';
import 'package:team_todo_app/features/auth/components/body.dart';

class LoginScreen extends StatelessWidget {
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
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: true,
    );
  }
}
