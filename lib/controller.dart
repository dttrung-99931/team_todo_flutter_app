import 'package:get/get.dart';

import '../../base/base_controller.dart';
import 'modules/team/model.dart';
import 'modules/team/service.dart';

class MainController extends BaseController {
  
  final selectedTeamObs = Rx<TeamModel>();
  // @TODO create properties for this
  // because it is global data, need to be abstracted
  TeamModel get selectedTeam => selectedTeamObs.value;
  
  final _teamService = Get.find<TeamService>();

  Future<void> selectTeamByID(String teamID) async {
    var team = await _teamService.getByID(teamID);
    selectedTeamObs.value = team;
  }
}
