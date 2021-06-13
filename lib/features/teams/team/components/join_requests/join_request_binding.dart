import 'package:get/get.dart';
import 'package:team_todo_app/features/teams/team/components/join_requests/join_request_controller.dart';

class JoinRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(JoinRequestController());
  }
}
