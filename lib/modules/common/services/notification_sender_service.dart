import 'package:get/get.dart';
import 'package:team_todo_app/modules/common/models/notification_data_model.dart';
import 'package:team_todo_app/modules/common/models/notification_sender_model.dart';
import 'package:team_todo_app/utils/utils.dart';

class NotificationSenderService extends GetConnect {
  static const String FCM_NOTI_URL = 'https://fcm.googleapis.com/fcm/send';
  static const String FCM_SERVER_KEY =
      'AAAAIfYWR8w:APA91bHs5aFj27lYdldis0TGiEXn9ypM9Er6rh7xkBANvjxK9Qw_GhxmTSWvSs4qOd2oNWvi7K5G9K9MNwbfyehx72a1eR_P3KO8WwwpWzYKebEU9kZmnyR-WqCsSHf0pmANjEKS8M2d';
  static const Map<String, String> HEADERS = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$FCM_SERVER_KEY',
  };

  Future<void> send(String fcmToken, String notiId, String notiTitle) async {
    var notiData = NotificationDataModel(
      notiID: notiId,
      title: notiTitle,
      date: DateTime.now(),
    );
    var noti = NotificationSenderModel(data: notiData, to: fcmToken);
    final body = noti.toMap();
    var response = await post(FCM_NOTI_URL, body, headers: HEADERS);
    if (!response.isOk) {
      logd(response.body);
    }
  }
}
