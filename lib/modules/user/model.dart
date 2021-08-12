import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String email;
  final String fcmToken;

  UserModel({
    @required this.id,
    @required this.email,
    @required this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fcmToken': fcmToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      fcmToken: map['fcmToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
