import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/modules/common/models/notification_data_model.dart';
import 'package:team_todo_app/utils/utils.dart';

class PushNotificationService extends GetxService {
  final messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin notiPluggin;

  Future<void> setup() async {
    await requestPermissions();
    await configPushNoti();
    listenPushNoti();
  }

  Future requestPermissions() async {
    final notiSettings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );
    // ...
  }

  Future<String> getFcmToken() async {
    return await messaging.getToken();
  }

  Future<void> configPushNoti() async {
    final androidNotiSetting = AndroidInitializationSettings(
      // @TODO insert an app icon to drawable and replace 'background 'with app icon name
      'background',
    );
    final notiSettings = InitializationSettings(android: androidNotiSetting);
    notiPluggin = FlutterLocalNotificationsPlugin();
    await notiPluggin.initialize(notiSettings);
  }

  void listenPushNoti() {
    FirebaseMessaging.onMessage.listen((event) {
      pushNoti(event);
    });
  }

  Future<void> pushNoti(RemoteMessage event) async {
    logd(event.data, "Notifcation");
    
    // @TODO: Fix to remove the code converting event.data['date'] from string to int below
    // Don't know why NotificationDataModel.date become string when receiving
    event.data[Fields.date] = int.parse(event.data[Fields.date]);
    
    final androidNotiDetails = AndroidNotificationDetails(
      'ChannelID',
      'ChannelName',
      'ChannnelDescription',
    );
    final notiDetails = NotificationDetails(android: androidNotiDetails);
    final notiData = NotificationDataModel.fromMap(event.data);
    await notiPluggin.show(
      // @TODO: make sure the id will be unique 
      DateTime.now().millisecondsSinceEpoch % 10000,
      notiData.title,
      'Team todo notification',
      notiDetails,
    );
  }
}
