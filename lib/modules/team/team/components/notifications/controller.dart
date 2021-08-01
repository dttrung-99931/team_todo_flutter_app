import 'package:get/get.dart';

import '../../../../../base/base_controller.dart';
import '../../../action_model.dart';
import '../../../controller.dart';
import '../../../service.dart';

class TeamNotificationsController extends BaseController {
  final _teamsController = Get.find<TeamController>();
  final _teamsServices = Get.find<TeamService>();
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
