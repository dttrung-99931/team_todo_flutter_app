import 'package:get/get.dart';

import '../../../../../../base/base_controller.dart';
import '../action/action_model.dart';
import '../../../../controller.dart';
import '../../../../service.dart';

class TeamActivityController extends BaseController {
  final _teamController = Get.find<TeamController>();
  final _teamServices = Get.find<TeamService>();
  final _activities = RxList<ActionModel>();
  List<ActionModel> get activities => _activities.toList();

  @override
  Future<void> onInit() async {
    super.onInit();
    this.load(() async {
      final activities = await _teamServices.getActions(
        _teamController.selectedTeam.id,
      );
      _activities.assignAll(activities);
    });
  }
}
