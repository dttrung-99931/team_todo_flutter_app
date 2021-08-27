import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/utils/utils.dart';

class FirebaseMessagingService extends GetxService {
  final messaging = FirebaseMessaging.instance;

  Future<void> setup() async {
    await requestPermissions();
    configPushNoti();
    FirebaseMessaging.onMessage.listen((event) {
      pushNoti(event);
    });
  }

  Future requestPermissions() async {
    final notiSettings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );
  }

  Future<String> getFcmToken() async {
    return await messaging.getToken();
  }

  void pushNoti(RemoteMessage event) {
    logd(event.data);
  }

  void configPushNoti() {
    // final androidNotiSetting = 
  }
}
