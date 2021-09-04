import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'notification_data_model.dart';

class NotificationSenderModel {
  final String to;
  final NotificationDataModel data;
  final String priority;

  NotificationSenderModel({
    @required this.to,
    @required this.data,
    this.priority =  'high',
  });

  Map<String, dynamic> toMap() {
    return {
      'to': to,
      'data': data.toMap(),
      'priority': priority,
    };
  }

  factory NotificationSenderModel.fromMap(Map<String, dynamic> map) {
    return NotificationSenderModel(
      to: map['to'],
      data: NotificationDataModel.fromMap(map['data']),
      priority: map['priority'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationSenderModel.fromJson(String source) => NotificationSenderModel.fromMap(json.decode(source));
 }
