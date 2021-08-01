import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../controller.dart';

class Body extends GetWidget<AuthController> {
  final _usernameEdtController = TextEditingController(text: 'user@gmail.com');
  final _passwordEdtController = TextEditingController(text: 'useruser');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      margin: const EdgeInsets.only(top: 96, bottom: 64, left: 16, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: 48,
          ),
          _buildLoginTitle(),
          _buildTextFormField("Email", _usernameEdtController),
          SizedBox(
            height: 8,
          ),
          _buildTextFormField("Password", _passwordEdtController,
              obscureText: true),
          SizedBox(
            height: 24,
          ),
          _buildLoginButton(),
          _buildSwitchLoginSignupBtn()
        ],
      ),
    );
  }

  _buildLoginTitle() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Text(
              controller.isLoginScreen ? "Login" : "Sign up",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: kPrimarySwatch,
                fontStyle: FontStyle.italic,
              ),
            )));
  }

  Widget _buildTextFormField(String hint, TextEditingController edtController,
      {bool obscureText = false}) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(gapPadding: 0),
          contentPadding: EdgeInsets.all(8)),
      controller: edtController,
      obscureText: obscureText,
    );
  }

  Widget _buildLoginButton() {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => ElevatedButton(
              onPressed: _onBtnLoginOrSignUpClicked,
              child: controller.isLoading
                  ? Container(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : buildTitleObx(style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  Obx buildTitleObx(
      {TextStyle style, String loginTitle = 'Login', signUpTitle = 'Sign up'}) {
    return Obx(
      () => Text(controller.isLoginScreen ? loginTitle : signUpTitle,
          style: style),
    );
  }

  Future<void> _onBtnLoginOrSignUpClicked() async {
    if (!_validate()) {
      return;
    }

    if (controller.isLoginScreen) {
      await login();
    } else {
      await signUp();
    }
  }

  Future login() async {
    var isloggedInSuccess = await controller.login(
        _usernameEdtController.text, _passwordEdtController.text);
    if (isloggedInSuccess) {
      Get.toNamed("/");
    } else {
      Get.showSnackbar(GetBar(
        message: "Login failed",
        isDismissible: true,
      ));
    }
  }

  Future signUp() async {
    var isSignInSuccess = await controller.signUp(
        _usernameEdtController.text, _passwordEdtController.text);
    if (isSignInSuccess) {
      Get.toNamed("/");
    } else {
      Get.showSnackbar(GetBar(
        message: "Login failed",
        isDismissible: true,
      ));
    }
  }

  bool _validate() {
    return true;
  }

  _buildSwitchLoginSignupBtn() {
    return TextButton(
        onPressed: () {
          controller.swithScreen();
        },
        child: buildTitleObx(
          loginTitle: "Sign up",
          signUpTitle: "Login",
        ));
  }
}
