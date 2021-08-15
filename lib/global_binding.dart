import 'package:get/get.dart';

import 'modules/auth/controller.dart';
import 'modules/common/services/notification_sender_service.dart';
import 'modules/notification/controller.dart';
import 'modules/common/services/firebase_messaging_service.dart';
import 'modules/team/components/team/components/actions/service.dart';
import 'modules/team/components/team/components/todo_board/components/task/service.dart';
import 'modules/common/services/firebase_auth_service.dart';
import 'modules/user/service.dart';
import 'package:team_todo_app/modules/notification/service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Provide dependencies used before GetMaterialApp created
    Get.put(FirebaseAuthService());
    // @TODO: remove UserService depending on FirebaseAuthService
    Get.put(UserService());
    Get.put(FirebaseMessagingService());
    Get.put(AuthController());
    
    // Provide dependencies for screens after [LoginScreen]
    Get.lazyPut(() => NotificationSenderService(), fenix: true);
    Get.lazyPut(() => TaskService(), fenix: true);
    Get.lazyPut(() => ActionService(), fenix: true);
    Get.lazyPut(() => NotificationService(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
  }
}
