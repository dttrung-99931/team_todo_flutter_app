import 'package:get/get.dart';
import 'package:team_todo_app/modules/team/components/team/components/todo_board/components/task/service.dart';
import 'package:team_todo_app/modules/user/service.dart';

import '../../../../../../base/base_controller.dart';
import '../../../../controller.dart';
import 'model.dart';
import 'service.dart';

class TeamActionController extends BaseController {
  final _teamController = Get.find<TeamController>();
  final _taskService = Get.find<TaskService>();
  final _userService = Get.find<UserService>();
  final _actionService = Get.find<ActionService>();
  final _activities = RxList<ActionModel>();
  List<ActionModel> get activities => _activities.toList();

  String get selectedTeamID => _teamController.selectedTeam.id;

  @override
  Future<void> onInit() async {
    super.onInit();
    _taskService.selectedTeamID = selectedTeamID;
    _actionService.selectedTeamID = selectedTeamID;

    this.load(() async {
      final activities = await getActions(
        _teamController.selectedTeam.id,
      );
      _activities.assignAll(activities);
    });
  }

  Future<List<ActionModel>> getActions(String teamID) async {
    final actions = await _actionService.getActions();
    await Future.wait([
      _taskService.loadTasksForActions(actions),
      _userService.loadUsersForActions(actions),
    ]);
    return actions;
  }
}
