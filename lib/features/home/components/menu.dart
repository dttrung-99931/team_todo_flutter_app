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
              _buildMenuItem("Orders", Icons.table_view_outlined, () {
                Get.toNamed("/orders");
              }),
              _buildMenuItem("Customers", Icons.person_outline, () {}),
              _buildMenuItem("Products", Icons.ad_units_outlined, () {}),
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
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                iconData,
                size: 48,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
