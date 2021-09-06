import 'package:flutter/material.dart';

import '../../../../../base/base_get_widget.dart';
import '../../../../../constants/constants.dart';
import '../controller.dart';

class AddMemberDialog extends BaseGetWidget<MembersController> {
  final _emailTxtController = TextEditingController();

  AddMemberDialog({Key key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: kDefaultPadding * 14,
          horizontal: kDefaultPadding * 2,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Form(
              child: Column(
                children: [
                  _buildTitle(context),
                  _buildEmailTxtForm(),
                  SizedBox(
                    height: 8,
                  ),
                  _buildOKBtn()
                ],
              ),
            ),
          ),
        ));
  }

  Container _buildTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding * 1.5),
      child: Text(
        'Add new member',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: kPrimarySwatch, fontWeight: FontWeight.bold),
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
              onPressed: () {
                controller.addMember(_emailTxtController.text);
              },
              child: buildLoadingObx(Text('OK'))),
        )),
      ],
    );
  }

  Widget _buildEmailTxtForm() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: TextFormField(
        autofocus: true,
        controller: _emailTxtController,
        decoration: InputDecoration(
            labelText: 'Email', border: OutlineInputBorder(gapPadding: 0)),
      ),
    );
  }
}
