import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';

class BaseController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  @protected
  set isLoading(bool value) => _isLoading.value = value;

  void load(Function load) {
    isLoading = true;
    load();
    isLoading = false;
  }
}
