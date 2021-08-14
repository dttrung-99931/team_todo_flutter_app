import 'package:get/get.dart';

import 'modules/auth/controller.dart';
import 'modules/common/services/notification_sender_service.dart';
import 'modules/notification/controller.dart';
import 'modules/common/services/firebase_messaging_service.dart';
import 'modules/team/components/team/components/action/service.dart';
import 'modules/team/components/team/components/todo_board/components/task/service.dart';
import 'modules/common/services/firebase_auth_service.dart';
import 'modules/user/service.dart';
import 'package:team_todo_app/modules/notification/service.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {

    // Common
    Get.put(FirebaseMessagingService());
    Get.put(FirebaseAuthService());
    Get.put(NotificationSenderService());

    // Auth
    Get.put(UserService());
    Get.put(AuthController());
    
    // notification
    Get.put(TaskService());
    Get.put(ActionService());
    Get.put(NotificationService());
    Get.put(NotificationController());

  }
}
