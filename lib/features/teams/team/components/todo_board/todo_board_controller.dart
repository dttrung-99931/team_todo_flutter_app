import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';
import 'package:team_todo_app/features/teams/team/components/members/member_model.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/task_model.dart';
import 'package:team_todo_app/utils/constants.dart';

import '../../../teams_controller.dart';
import '../../../teams_service.dart';

class TodoBoardController extends BaseController {
  final _teamsController = Get.find<TeamsController>();
  final _teamsService = Get.find<TeamsService>();
  final _members = RxList<MemberModel>();
  List<MemberModel> get members => _members.toList();

  final _todoTasks = RxList<TaskModel>();
  List<TaskModel> get todoTasks => _todoTasks.toList();

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

  Future<void> loadTasks() async {
    final tasks = await _teamsService.getasks(_teamsController.selectedTeam.id);
    final todoTasks = List<TaskModel>.empty(growable: true);
    final doingTasks = List<TaskModel>.empty(growable: true);
    final finishTasks = List<TaskModel>.empty(growable: true);
    tasks.forEach((element) {
      if (element.status == TaskStatus.Todo.stringValue()) {
        todoTasks.add(element);
      }
    });
    _orderTasksByStatusChangedDate(todoTasks);
    _todoTasks.assignAll(todoTasks);
  }

  void _orderTasksByStatusChangedDate(List<TaskModel> todoTasks) {
    todoTasks.sort((task1, task2) =>
        -task1.statusChangedDate.compareTo(task2.statusChangedDate));
  }
}
