import 'package:get/get.dart';
import 'package:team_todo_app/modules/notification/service.dart';
import 'package:team_todo_app/modules/nteam/components/todo_board/components/task/service.dart';
import 'package:team_todo_app/modules/user/service.dart';

import '../../../../base/base_controller.dart';
import '../../controller.dart';
import 'model.dart';
import 'service.dart';

class TeamActionController extends BaseController {
  final _teamController = Get.find<TeamController>();
  final _taskService = Get.find<TaskService>();
  final _userService = Get.find<UserService>();
  final _actionService = Get.find<ActionService>();
  final _notiService = Get.find<NotificationService>();
  final _actions = RxList<ActionModel>();
  List<ActionModel> get actions => _actions.toList();

  String get selectedTeamID => _teamController.selectedTeam.id;

  @override
  Future<void> onInit() async {
    super.onInit();
    _taskService.selectedTeamID = selectedTeamID;
    _actionService.selectedTeamID = selectedTeamID;

    this.load(() async {
      final actions = await getActions(
        _teamController.selectedTeam.id,
      );
      await setActionsSeenAndUpdateNotisSeen(actions);
      _teamController.clearNewActionIDs();
      _actions.assignAll(actions);
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

  Future<void> setActionsSeenAndUpdateNotisSeen(
      List<ActionModel> actions) async {
    if (actions.isEmpty) return;
    
    final taskNotis =
        // @FIXME: Firestore limit maximum 10 filter array items
        await _notiService.loadTaskNotis(actions.map((e) => e.id).toList());
    final newTaskNotis = taskNotis.where((element) => !element.isSeen);
    final newActionIDs = newTaskNotis.map((e) => e.referenceID).toList();
    actions.forEach((element) {
      element.isSeen = !newActionIDs.contains(element.id);
    });
    await _notiService.updateNotisSeen(newTaskNotis.map((e) => e.id).toList());
  }
}
