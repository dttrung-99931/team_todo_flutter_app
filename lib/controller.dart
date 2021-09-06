import 'package:get/get.dart';

import '../../base/base_controller.dart';
import 'modules/common/services/firebase_messaging_service.dart';
import 'modules/teams/model.dart';
import 'modules/teams/service.dart';

class MainController extends BaseController {
  final selectedTeamObs = Rx<TeamModel>();
  final _pushNotiService = Get.find<PushNotificationService>();

  // @TODO create properties for this
  // because it is global data, need to be abstracted
  TeamModel get selectedTeam => selectedTeamObs.value;

  final _teamService = Get.find<TeamService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    _pushNotiService.setup();
  }

  Future<void> selectTeamByID(String teamID) async {
    var team = await _teamService.getByID(teamID);
    selectedTeamObs.value = team;
  }
}
