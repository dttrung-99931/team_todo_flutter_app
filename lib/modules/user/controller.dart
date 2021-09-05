import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/modules/user/service.dart';

import '../../base/base_controller.dart';

class UserController extends BaseController {
  final _userService = Get.find<UserService>();
  User get user => _userService.user;
  String get userID => user?.uid;
}
