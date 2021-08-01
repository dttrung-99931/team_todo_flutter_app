import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/base_get_widget.dart';
import '../model.dart';
import '../controller.dart';
import 'components/body.dart';

class TeamPreviewScreen extends BaseGetWidget<TeamController> {
  final TeamModel team = Get.arguments as TeamModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(team: team),
      ),
    );
  }
}
