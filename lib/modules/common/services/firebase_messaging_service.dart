import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/constants.dart';
import 'package:team_todo_app/modules/common/models/notification_data_model.dart';
import 'package:team_todo_app/modules/notification/model.dart';
import 'package:team_todo_app/modules/notification/service.dart';
import 'package:team_todo_app/modules/team/components/team/components/actions/service.dart';
import 'package:team_todo_app/modules/team/components/team/components/todo_board/components/task/service.dart';
import 'package:team_todo_app/modules/team/service.dart';
import 'package:team_todo_app/utils/utils.dart';

import '../../../main.dart';

class PushNotificationService extends GetxService {
  final messaging = FirebaseMessaging.instance;
  final _notiService = Get.find<NotificationService>();
  // final _teamService = Get.find<TeamService>();
  final _actionService = Get.find<ActionService>();
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
    await notiPluggin.initialize(notiSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String notiID) async {
    // var notiDetails = await notiPluggin.getNotificationAppLaunchDetails();
    var noti = await _notiService.getByID(notiID);
    if (noti.type == NotificationModel.TYPE_ACTION) {
      var teamID = await _actionService.getTeamIDOfAction(noti.referenceID);
      startApp(teamID: teamID);
    }
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
    final notiBody = await _notiService.buildPushNotiBody(notiData.notiID);

    await notiPluggin.show(
      // @TODO: make sure the id will be unique
      DateTime.now().millisecondsSinceEpoch % 10000,
      notiData.title,
      notiBody,
      notiDetails,
      payload: notiData.notiID,
    );
  }
}
