import 'package:get/get.dart';

import '../../../../../base/base_controller.dart';
import '../../../../../constants/constants.dart';
import '../../../../auth/service.dart';
import '../../../controller.dart';
import '../../../service.dart';
import '../members/model.dart';
import 'task/model.dart';

class TodoBoardController extends BaseController {
  final _teamsController = Get.find<TeamController>();
  final _teamsService = Get.find<TeamService>();
  final _authService = Get.find<AuthService>();
  final _members = RxList<MemberModel>();
  List<MemberModel> get members => _members.toList();

  String get appUserID => _authService.user.uid;

  final _todoTasks = RxList<TaskModel>();
  List<TaskModel> get todoTasks => _todoTasks.toList();

  final _doingTasks = RxList<TaskModel>();
  List<TaskModel> get doingTasks => _doingTasks.toList();

  final _finishTasks = RxList<TaskModel>();
  List<TaskModel> get finishTasks => _finishTasks.toList();

  @override
  void onInit() {
    load(() async {
      loadTasks();
      final members =
          await _teamsService.loadTeamMemebers(_teamsController.selectedTeam);
      _members.assignAll(members);
    });
    super.onInit();
  }

  Future<void> addTask(TaskModel task) async {
    await load(() async {
      await _teamsService.addTask(_teamsController.selectedTeam.id, task);
      _todoTasks.insert(0, task);
    });
  }

  /// @TODO simplify
  Future<void> loadTasks() async {
    final tasks = await _teamsService.getasks(_teamsController.selectedTeam.id);
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
    _orderTasksByStatusChangedDate(todoTasks);
    _todoTasks.assignAll(todoTasks);
    _orderTasksByStatusChangedDate(doingTasks);
    _doingTasks.assignAll(doingTasks);
    _orderTasksByStatusChangedDate(finishTasks);
    _finishTasks.assignAll(finishTasks);
  }

  void _orderTasksByStatusChangedDate(List<TaskModel> todoTasks) {
    todoTasks.sort((task1, task2) =>
        -task1.statusChangedDate.compareTo(task2.statusChangedDate));
  }

  Future<void> moveTask(
      TaskModel task, int fromBoardIndex, int toBoardIndex) async {
    task.status = TaskStatus.values[toBoardIndex].stringValue();
    getRxTasksInBoard(fromBoardIndex)
        .removeWhere((element) => element.id == task.id);
    getRxTasksInBoard(toBoardIndex).insert(0, task);

    await _teamsService.updateTask(_teamsController.selectedTeam.id, task);
  }

  RxList<TaskModel> getRxTasksInBoard(int boardIndex) {
    return [_todoTasks, _doingTasks, _finishTasks][boardIndex];
  }

  Future<void> updateTask(TaskModel task, int boardIndex) async {
    await _teamsService.updateTask(_teamsController.selectedTeam.id, task);
    final rxTasks = getRxTasksInBoard(boardIndex);
    final index = rxTasks.indexWhere((element) => element.id == task.id);
    rxTasks[index] = task;
    rxTasks.refresh();
  }

  void deleteTask(String taskID, int fromBoard) {
    load(() async {
      await _teamsService.deleteTask(_teamsController.selectedTeam.id, taskID);
      getRxTasksInBoard(fromBoard)
          .removeWhere((element) => element.id == taskID);
    });
  }
}
