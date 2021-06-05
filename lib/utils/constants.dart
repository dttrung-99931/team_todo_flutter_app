import 'package:flutter/material.dart';

class Collections {
  static const Users = "users";
}

class Fields {
  static const email = "email";
}

const kPrimarySwatch = Colors.teal;
final kAppTheme = ThemeData(
    primarySwatch: kPrimarySwatch,
    scaffoldBackgroundColor: Colors.grey[300],
    primaryIconTheme: IconThemeData(color: kPrimarySwatch),
    iconTheme: IconThemeData(color: kPrimarySwatch),
    accentIconTheme: IconThemeData(color: kPrimarySwatch));
const double kDefaultPadding = 8;
