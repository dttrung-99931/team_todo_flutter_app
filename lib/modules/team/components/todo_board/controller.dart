import 'package:get/get.dart';
import 'package:team_todo_app/modules/team/model.dart';
import '../../../common/services/notification_sender_service.dart';
import '../actions/model.dart';
import '../actions/service.dart';
import '../../../user/model.dart';
import '../../../../utils/utils.dart';

import '../../../../base/base_controller.dart';
import '../../../../constants/constants.dart';
import '../../../user/service.dart';
import '../../controller.dart';
import '../../service.dart';
import '../members/model.dart';
import 'components/task/model.dart';
import 'components/task/service.dart';

class TodoBoardController extends BaseController {
  final _teamController = Get.find<TeamController>();
  final _teamsService = Get.find<TeamService>();
  final _userService = Get.find<UserService>();
  final _taskService = Get.find<TaskService>();
  final _actionService = Get.find<ActionService>();
  final _notiSenderService = Get.find<NotificationSenderService>();

  final _members = RxList<MemberModel>();
  List<MemberModel> get members => _members.toList();

  String get appUserID => _userService.user.uid;

  final _todoTasks = RxList<TaskModel>();
  List<TaskModel> get todoTasks => _todoTasks.toList();

  final _doingTasks = RxList<TaskModel>();
  List<TaskModel> get doingTasks => _doingTasks.toList();

  final _finishTasks = RxList<TaskModel>();
  List<TaskModel> get finishTasks => _finishTasks.toList();

  String get selectedTeamID => _teamController.selectedTeam.id;

  @override
  void onInit() {
    if (_teamController.selectedTeamObs.value != null) {
      loadData();
    }
    listen<TeamModel>(_teamController.selectedTeamObs, (team) {
      loadData();
    });
    super.onInit();
  }

  void loadData() {
    _taskService.selectedTeamID = selectedTeamID;
    _actionService.selectedTeamID = selectedTeamID;
    load(() async {
      await loadMembers();
      await loadTasks();
    });
  }

  Future loadMembers() async {
    final members = await _teamsService.loadTeamMemebers(
      _teamController.selectedTeam,
    );
    _members.assignAll(members);
  }

  Future<void> addTask(TaskModel task) async {
    await load(() async {
      final taskID = await _taskService.addTask(task);
      final actionID = await _actionService.addAction(
        ActionModel.TYPE_ADD_TASK,
        taskID,
      );
      await addNotiForMembers(
        actionID,
        selectedTeamID,
        "Add task " + task.title,
      );

      _todoTasks.insert(0, task);
    });
  }

  Future<void> addNotiForMembers(
    String actionId,
    String teamID,
    String notiTitle,
  ) async {
    var teamMemberIDs = _teamController.selectedTeam.userIDs;
    var futures = teamMemberIDs.map<Future>(
      (userID) => addNotiForMember(userID, teamID, actionId, notiTitle),
    );
    await Future.wait(futures);
  }

  Future<void> addNotiForMember(
    String userID,
    String teamID,
    String actionId,
    String notiTitle,
  ) {
    return _userService
        .addTaskNoti(userID, teamID, actionId)
        .then((notiId) async {
      // Not send noti to the sender user
      // if (userID == _userService.userID) return;

      var fcmToken = await _userService.getFcmToken(userID);
      if (isNotNullAndEmpty(fcmToken)) {
        await _notiSenderService.send(fcmToken, notiId, notiTitle);
      }
    });
  }

  /// @TODO simplify
  Future<void> loadTasks() async {
    final tasks = await _taskService.getTasks();
    setAssigneesForTasks(tasks);
    final todoTasks = List<TaskModel>.empty(growable: true);
    final doingTasks = List<TaskModel>.empty(growable: true);
    final finishTasks = List<TaskModel>.empty(growable: true);
    tasks.forEach((element) {
      if (element.status == TaskStatus.Todo.stringValue()) {
        todoTasks.add(element);
      } else if (element.status == TaskStatus.Doing.stringValue()) {
        doingTasks.add(element);
      } else if (element.status == TaskStatus.Finish.stringValue()) {
        finishTasks.add(element);
      } else {
        throw Exception('Task status = ${element.status}');
      }
    });
    orderTasksByStatusChangedDate(todoTasks);
    _todoTasks.assignAll(todoTasks);
    orderTasksByStatusChangedDate(doingTasks);
    _doingTasks.assignAll(doingTasks);
    orderTasksByStatusChangedDate(finishTasks);
    _finishTasks.assignAll(finishTasks);
  }

  void orderTasksByStatusChangedDate(List<TaskModel> todoTasks) {
    todoTasks.sort((task1, task2) =>
        -task1.statusChangedDate.compareTo(task2.statusChangedDate));
  }

  Future<void> moveTask(
      TaskModel task, int fromBoardIndex, int toBoardIndex) async {
    var updatedFields = {Fields.status: task.status};

    task.status = TaskStatus.values[toBoardIndex].stringValue();
    getTasksInBoard(fromBoardIndex)
        .removeWhere((element) => element.id == task.id);
    getTasksInBoard(toBoardIndex).insert(0, task);

    await _taskService.updateTask(
      task,
      updatedFields: updatedFields,
    );
    final actionID = await _actionService.addAction(
      ActionModel.TYPE_UPDATE_TASK,
      task.id,
    );
    await addNotiForMembers(
      actionID,
      selectedTeamID,
      "Updated task " + task.title,
    );
  }

  RxList<TaskModel> getTasksInBoard(int boardIndex) {
    return [_todoTasks, _doingTasks, _finishTasks][boardIndex];
  }

  /// Update task
  ///
  /// Update task in firebase, pass the [updatedFields] containing the updated fields to service
  /// to create the update action.
  /// Then sync with the task of task rxLists in controller
  Future<void> updateTask(TaskModel task, int boardIndex) async {
    final tasks = getTasksInBoard(boardIndex);
    final index = tasks.indexWhere((element) => element.id == task.id);
    tasks[index] = task;

    var newTaskMap = task.toMap();
    var oldTaskMap = tasks[index].toMap();
    var updatedFields = diff(newTaskMap, oldTaskMap);

    await _taskService.updateTask(
      task,
      updatedFields: updatedFields,
    );
    final actionID = await _actionService.addAction(
      ActionModel.TYPE_UPDATE_TASK,
      task.id,
    );
    await addNotiForMembers(
        actionID, selectedTeamID, "Updated task " + task.title);

    tasks.refresh();
  }

  void deleteTask(String taskID, int fromBoard) {
    load(() async {
      await _taskService.deleteTask(taskID);
      final actionID = await _actionService.addAction(
        ActionModel.TYPE_DEL_TASK,
        taskID,
      );
      await addNotiForMembers(
          actionID, selectedTeamID, "Deleted task " + taskID);

      getTasksInBoard(fromBoard).removeWhere((element) => element.id == taskID);
    });
  }

  void setAssigneesForTasks(List<TaskModel> tasks) {
    tasks.forEach((element) {
      element.assigneeUser = getUser(element.assigneeUserID);
    });
  }

  UserModel getUser(String userID) {
    final query = members.where(
      (element) => element.user.id == userID,
    );
    return query.isNotEmpty ? query.first.user : null;
  }
}
