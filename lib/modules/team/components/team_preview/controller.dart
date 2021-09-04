import 'package:get/get.dart';

import '../../../../base/base_controller.dart';
import '../../../nteam/controller.dart';
import '../../service.dart';

class TeamPreviewController extends BaseController {
  final _teamsService = Get.find<TeamService>();
  // final _teamsService = Get.find<TeamsService>();
  final _teamsController = Get.find<TeamController>();

  Future<void> jointTeam(String teamID) async {
    isLoading = true;
    await _teamsService.requestJoinTeam(teamID);
    isLoading = false;
    _teamsController.loadMyTeams();
  }
}
