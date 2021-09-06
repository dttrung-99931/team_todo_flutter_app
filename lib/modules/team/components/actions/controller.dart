import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../notification/service.dart';
import '../todo_board/components/task/service.dart';
import '../../../user/service.dart';

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

  DocumentSnapshot lastActionDocSnap;
  var canLoadMore = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    // @TODO: find a better solution for set selected team ID in services
    _taskService.selectedTeamID = selectedTeamID;
    _actionService.selectedTeamID = selectedTeamID;
    lastActionDocSnap = null;
    load(loadMoreActions);
  }

  Future<void> loadMoreActions() async {
    final actionDocs = await _actionService.getActionDocs(
      startAfterDoc: lastActionDocSnap,
    );
    if (actionDocs.isNotEmpty) {
      lastActionDocSnap = actionDocs.last;
    } else {
      canLoadMore = false;
      _actions.refresh();
    }
    final actions = _actionService.docsToModels(actionDocs);
    await updateActionsAndNotisSeen(actions);
    _teamController.clearNewActionIDs();
    _actions.addAll(actions);
  }

  Future<List<ActionModel>> getActions(String teamID) async {
    final actions = await _actionService.getActions();
    await Future.wait([
      _taskService.loadTasksForActions(actions),
      _userService.loadUsersForActions(actions),
    ]);
    return actions;
  }

  /// Update Action.isSeen = true for all [actions]
  /// Also update seen for the corresponding notifications of [actions]
  Future<void> updateActionsAndNotisSeen(List<ActionModel> actions) async {
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
