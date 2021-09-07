import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/font_sizes.dart';
import 'package:team_todo_app/constants/routes.dart';
import 'package:team_todo_app/constants/sizes.dart';

import '../../../constants/constants.dart';
import '../controller.dart';

class Body extends GetWidget<AuthController> {
  final _usernameEdtController = TextEditingController(text: 'user@gmail.com');
  final _passwordEdtController = TextEditingController(text: 'useruser');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.s24, vertical: 8),
      margin: const EdgeInsets.only(
        top: Sizes.s24,
        bottom: Sizes.s128,
        left: Sizes.s16,
        right: Sizes.s16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s24)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: Sizes.s48),
          buildLoginTitle(),
          SizedBox(height: Sizes.s8),
          buildTextFormField("Email", _usernameEdtController),
          SizedBox(height: Sizes.s8),
          buildTextFormField("password".tr, _passwordEdtController,
              obscureText: true),
          SizedBox(height: Sizes.s24),
          buildLoginButton(),
          buildSwitchLoginSignupBtn(),
        ],
      ),
    );
  }

  buildLoginTitle() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Text(
              controller.isLoginScreen ? 'login'.tr : 'sign-up'.tr,
              style: TextStyle(
                fontSize: FontSizes.s28,
                fontWeight: FontWeight.bold,
                color: kPrimarySwatch,
                fontStyle: FontStyle.italic,
              ),
            )));
  }

  Widget buildTextFormField(String hint, TextEditingController edtController,
      {bool obscureText = false}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(Sizes.s12),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: Sizes.s12,
          horizontal: Sizes.s12,
        ),
        isDense: true,
      ),
      controller: edtController,
      obscureText: obscureText,
    );
  }

  Widget buildLoginButton() {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.s12),
              )),
              onPressed: onBtnLoginOrSignUpClicked,
              child: controller.isLoading
                  ? Container(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : buildTitleObx(
                      style: TextStyle(color: Colors.white),
                      titleOnLogin: 'login'.tr,
                      titleOnSignup: 'sign-up'.tr,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Obx buildTitleObx({
    TextStyle style,
    String titleOnLogin,
    String titleOnSignup,
  }) {
    return Obx(
      () => Text(controller.isLoginScreen ? titleOnLogin : titleOnSignup,
          style: style),
    );
  }

  Future<void> onBtnLoginOrSignUpClicked() async {
    if (!validate()) {
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
      Get.offAndToNamed(RouteNames.HOME);
    } else {
      Get.showSnackbar(
        GetBar(
          message: 'login-failed'.tr,
          isDismissible: true,
        ),
      );
    }
  }

  Future signUp() async {
    var isSignInSuccess = await controller.signUp(
        _usernameEdtController.text, _passwordEdtController.text);
    if (isSignInSuccess) {
      Get.offAndToNamed(RouteNames.HOME);
    } else {
      Get.showSnackbar(GetBar(
        message: 'login-failed'.tr,
        isDismissible: true,
      ));
    }
  }

  bool validate() {
    return true;
  }

  buildSwitchLoginSignupBtn() {
    return Transform.translate(
      offset: Offset(0, -Sizes.s4),
      child: TextButton(
        onPressed: () {
          controller.switchScreen();
        },
        child: buildTitleObx(
          titleOnLogin: 'sign-up'.tr,
          titleOnSignup: 'login'.tr,
        ),
      ),
    );
  }
}
