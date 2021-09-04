import 'package:get/get.dart';
import 'package:team_todo_app/controller.dart';
import 'package:team_todo_app/modules/nteam/controller.dart';
import 'package:team_todo_app/modules/user/service.dart';

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
