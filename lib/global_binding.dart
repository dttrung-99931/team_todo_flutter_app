import 'package:get/get.dart';
import 'controller.dart';
import 'modules/error_handler/error_report_service.dart';
import 'modules/teams/service.dart';

import 'modules/auth/controller.dart';
import 'modules/common/services/notification_sender_service.dart';
import 'modules/notification/controller.dart';
import 'modules/common/services/firebase_messaging_service.dart';
import 'modules/team/components/actions/service.dart';
import 'modules/team/components/todo_board/components/task/service.dart';
import 'modules/common/services/firebase_auth_service.dart';
import 'modules/user/controller.dart';
import 'modules/user/service.dart';
import 'modules/notification/service.dart';

class GlobalBinding extends Bindings {
  // Provide dependencies used before GetMaterialApp created
  @override
  void dependencies() {
    Get.put(ErrorReportService());
    Get.put(FirebaseAuthService());

//->// @TODO: remove services depending on other services
    // like UserService depending on FirebaseAuthService for the below ones
    Get.put(UserService());
    Get.put(TaskService());
    Get.put(ActionService());
    Get.put(NotificationService());
    Get.put(PushNotificationService());
    Get.put(AuthController());
    Get.put(UserController());

    // Provide dependencies for screens after [LoginScreen]
    Get.lazyPut(() => NotificationSenderService(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);

    Get.put(TeamService());
    Get.put(MainController());
  }
}
