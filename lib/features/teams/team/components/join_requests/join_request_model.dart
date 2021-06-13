import 'package:flutter/foundation.dart';

class JoinRequestModel {
  final String userID;
  final String email;
  final DateTime requestDate;
  JoinRequestModel({
    @required this.userID,
    @required this.email,
    @required this.requestDate,
  });
}
