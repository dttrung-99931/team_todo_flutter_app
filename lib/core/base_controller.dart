import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class BaseController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  @protected
  set isLoading(bool value) => _isLoading.value = value;

  Future<void> load(Function load) async {
    isLoading = true;
    await load();
    isLoading = false;
  }

  Future<void> showSnackbar(String msg) {
    return Get.showSnackbar(GetBar(
      message: msg,
      duration: Duration(seconds: 2),
    ));
  }
}
