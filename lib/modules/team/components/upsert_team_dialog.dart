import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../model.dart';
import '../controller.dart';

class UpsertTeamDialog extends GetWidget<TeamController> {
  final _nameTextCtl = TextEditingController();
  final _descTextCtl = TextEditingController();
  final TeamModel teamModel;
  String title;

  UpsertTeamDialog({
    this.teamModel,
  }) {
    if (teamModel != null) {
      title = 'Update team';
      _nameTextCtl.text = teamModel.name;
      _descTextCtl.text = teamModel.description;
    } else {
      title = 'Add team';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: kDefaultPadding * 9,
        horizontal: kDefaultPadding * 2,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: kDefaultPadding),
                  padding: const EdgeInsets.all(kDefaultPadding * 1.5),
                  child: Text(
                    'Add a team',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: kPrimarySwatch, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildTextFormField(controller: _nameTextCtl, hint: 'Name'),
                _buildTextFormField(
                    controller: _descTextCtl, hint: 'Description'),
                _buildOKBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOKBtn() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ElevatedButton(
              onPressed: _onBtnOKClicked,
              child: Obx(() => controller.isLoading
                  ? Container(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text('OK'))),
        )),
      ],
    );
  }

  Future<void> _onBtnOKClicked() async {
    final team = _buildTeamModel();
    if (teamModel != null) {
      teamModel.name = team.name;
      teamModel.description = team.description;
      await controller.update_(teamModel);
    } else {
      await controller.add(team);
    }
    Get.back();
  }

  TeamModel _buildTeamModel() {
    return TeamModel(
      name: _nameTextCtl.text,
      description: _descTextCtl.text,
      userIDs: [],
      pendingUserIDs: [],
    );
  }

  Card _buildTextFormField(
      {@required TextEditingController controller, @required String hint}) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            kDefaultPadding,
            0,
            kDefaultPadding,
            kDefaultPadding,
          ),
          child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  alignLabelWithHint: true,
                  labelText: hint))),
    );
  }
}
