import 'package:flutter/material.dart';
import '../utils/utils.dart';

class CharacterAvatar extends StatelessWidget {
  final Color color;
  const CharacterAvatar({
    Key key,
    @required this.name,
    Text child,
    this.color,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: name.isNotEmpty
          ? color != null
              ? color
              : Utils.stringToColor(name)
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
