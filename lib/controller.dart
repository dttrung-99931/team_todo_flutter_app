import 'package:get/get.dart';

import '../../base/base_controller.dart';
import 'modules/common/services/firebase_messaging_service.dart';
import 'modules/team/model.dart';
import 'modules/team/service.dart';

class MainController extends BaseController {
  final _pushNotiService = Get.find<PushNotificationService>();

  // Indicate the current selected team
  final selectedTeamObs = Rx<TeamModel>();
  TeamModel get selectedTeam => selectedTeamObs.value;

  final _teamService = Get.find<TeamService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    _pushNotiService.setup();
  }

  Future<void> selectTeamByID(String teamID) async {
    var team = await _teamService.getByID(teamID);
    selectTeam(team);
  }

  void selectTeam(TeamModel team) {
    selectedTeamObs.value = team;
  }
}
