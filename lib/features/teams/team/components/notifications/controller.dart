import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';
import 'package:team_todo_app/features/teams/action_model.dart';
import 'package:team_todo_app/features/teams/teams_controller.dart';
import 'package:team_todo_app/features/teams/teams_service.dart';

class TeamNotificationsController extends BaseController {
  final _teamsController = Get.find<TeamsController>();
  final _teamsServices = Get.find<TeamsService>();
  final _newActions = RxList<ActionModel>();
  List<ActionModel> get newActions => _newActions.toList();

  @override
  Future<void> onInit() async {
    super.onInit();
    this.load(() async {
      final actions = await _teamsServices.getActions(
        _teamsController.selectedTeam.id,
        _teamsController.newTeamActionIDs,
      );
      _newActions.assignAll(actions);
    });
  }
}
