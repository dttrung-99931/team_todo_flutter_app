import 'package:get/get.dart';
import 'package:team_todo_app/modules/team/components/team/components/action/service.dart';
import 'package:team_todo_app/modules/team/components/team/components/todo_board/components/task/service.dart';

import '../../../../../../base/base_controller.dart';
import '../action/action_model.dart';
import '../../../../controller.dart';

class TeamActivityController extends BaseController {
  final _teamController = Get.find<TeamController>();
  final _taskService = Get.find<TaskService>();
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

    var futures = actions.map(
      (e) => _taskService.getTask(e.taskID).then((task) => e.task = task),
    );
    await Future.wait(futures);
    return actions;
  }
}
