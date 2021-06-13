import 'package:flutter/material.dart';

class Collections {
  static const users = "users";
  static const teams = "teams";
}

class Fields {
  static const email = "email";
  static const teamIDs = "teamIDs";
  static const userIDs = "userIDs";
  static const pendingUserIDs = "pendingUserIDs";
  static const id = "id";
}

const kPrimarySwatch = Colors.teal;
final kAppTheme = ThemeData(
    primarySwatch: kPrimarySwatch,
    scaffoldBackgroundColor: Colors.grey[300],
    iconTheme: IconThemeData(color: kPrimarySwatch),
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)));
const double kDefaultPadding = 8;
