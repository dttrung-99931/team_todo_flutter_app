import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controller.dart';

class RecentOrders extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 1),
          child: Text("Recent orders",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        )
      ],
    );
  }
}
