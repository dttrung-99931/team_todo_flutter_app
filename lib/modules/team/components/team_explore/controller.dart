import 'package:get/get.dart';

import '../../../../base/base_controller.dart';
import '../../../../utils/utils.dart';
import '../../model.dart';
import '../../service.dart';

class TeamExploreController extends BaseController {
  final _teams = RxList<TeamModel>();
  get teams => _teams.toList();

  final _teamService = Get.find<TeamService>();
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
