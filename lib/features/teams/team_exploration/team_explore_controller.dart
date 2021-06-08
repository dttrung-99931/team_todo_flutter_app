import 'package:get/get.dart';
import 'package:team_todo_app/core/base_controller.dart';
import 'package:team_todo_app/utils/utils.dart';

import '../team_model.dart';
import '../teams_service.dart';

class TeamExploreController extends BaseController {
  final _teams = RxList<TeamModel>();
  get teams => _teams.toList();

  final _teamService = Get.find<TeamsService>();
  @override
  void onInit() {
    loadSuggestTeams();
    super.onInit();
  }

  Future<void> loadSuggestTeams() async {
    isLoading = true;
    final teams = await _teamService.getSuggestTeams(10);
    print('aaa');
    logd(teams);
    _teams.assignAll(teams);
    isLoading = false;
  }
}
