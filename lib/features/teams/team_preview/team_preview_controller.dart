import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';

import '../teams_controller.dart';
import '../teams_service.dart';

class TeamPreviewController extends BaseController {
  final _teamsService = Get.find<TeamsService>();
  // final _teamsService = Get.find<TeamsService>();
  final _teamsController = Get.find<TeamsController>();

  Future<void> jointTeam(String teamID) async {
    isLoading = true;
    await _teamsService.joinTeam(teamID);
    isLoading = false;
    _teamsController.loadMyTeams();
  }
}
