import 'package:flutter/material.dart';
import '../utils/utils.dart';

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: name.isNotEmpty
          ? Utils.stringToColor(name)
          : Colors.transparent,
      child: Text(
        (name.isNotEmpty ? name[0] : '').toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
