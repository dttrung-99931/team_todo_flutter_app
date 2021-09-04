import 'package:get/get.dart';
import '../../controller.dart';
import '../team/controller.dart';
import '../user/service.dart';

import '../../base/base_controller.dart';

class HomeController extends BaseController {
  final _userService = Get.find<UserService>();
  // final _mainController = Get.find<MainController>();

  final newNotiNum = RxInt();
  var areMyTeamsLoading = RxBool(true);

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadNewNotiNum();
  }

  Future<void> loadNewNotiNum() async {
    newNotiNum.value = await _userService.getNewNotiNum();
  }
}
