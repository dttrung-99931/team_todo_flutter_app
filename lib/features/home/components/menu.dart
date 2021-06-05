import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuItem("Teams", Icons.group_outlined, () {}),
              _buildMenuItem("Tasks", Icons.event_note_outlined, () {}),
              _buildMenuItem(
                  "Notifications", Icons.notifications_outlined, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData iconData, Function onTap) {
    return Card(
      elevation: 6,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: 96,
          height: 96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 44,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
