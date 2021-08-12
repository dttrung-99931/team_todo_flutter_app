import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotificationDataModel {
  final String title;
  final String notiID;
  final DateTime date;

  NotificationDataModel({
    @required this.title,
    @required this.notiID,
    @required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'notiID': notiID,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory NotificationDataModel.fromMap(Map<String, dynamic> map) {
    return NotificationDataModel(
      title: map['title'],
      notiID: map['notiID'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationDataModel.fromJson(String source) => NotificationDataModel.fromMap(json.decode(source));
}
