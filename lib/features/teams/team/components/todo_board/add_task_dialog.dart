import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/core/base_get_widget.dart';
import 'package:team_todo_app/features/teams/team/components/members/member_model.dart';
import 'package:team_todo_app/features/teams/team/components/todo_board/todo_board_controller.dart';
import 'package:team_todo_app/utils/constants.dart';
import 'package:team_todo_app/utils/utils.dart';

import 'choice_chips.dart';
import 'task_model.dart';

class AddTaskDialog extends BaseGetWidget<TodoBoardController> {
  AddTaskDialog();

  final _titleTxtController = TextEditingController();
  final _descTxtController = TextEditingController();
  final _startDateTxtController = TextEditingController();
  final _dueDateTxtController = TextEditingController();
  TaskStatus _status = TaskStatus.Todo;
  DateTime _startDate, _dueDate;
  final assignee = Rx<MemberModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: kDefaultPadding * 3,
          horizontal: kDefaultPadding * 1,
        ),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Form(
              child: SingleChildScrollView(
                child: _buildFormColumn(context),
              ),
            ),
          ),
        ));
  }

  Column _buildFormColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitle(context),
        _buildTaskStatusChoiceChips(),
        _buildAssigneeSelector(),
        _buildTxtFormField(
          'Title',
          _titleTxtController,
        ),
        _buildTxtFormField('Description', _descTxtController,
            inputType: TextInputType.multiline,
            minLines: 3,
            inputAction: TextInputAction.newline),
        _buildDateTxtFormField(context, 'Start date', _startDateTxtController,
            (date) => _startDate = date),
        _buildDateTxtFormField(context, 'Due date', _dueDateTxtController,
            (date) => _dueDate = date),
        SizedBox(
          height: 8,
        ),
        _buildOKBtn()
      ],
    );
  }

  Widget _buildDateTxtFormField(
      BuildContext context,
      String lable,
      TextEditingController controller,
      Function(DateTime date) onDateSelected) {
    return _buildTxtFormField(lable, controller,
        inputType: TextInputType.datetime,
        isReadOnly: true, onClicked: () async {
      final selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 2),
          initialDate: DateTime.now());
      controller.text = formatDate(selectedDate);
      onDateSelected(selectedDate);
    });
  }

  Widget _buildTitle(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding * 1),
        child: Text(
          'Add task',
          style: TextStyle(
            color: kPrimarySwatch,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildAssigneeSelector() {
    return Padding(
        padding: EdgeInsets.all(8),
        child: InputDecorator(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding, horizontal: kDefaultPadding * 1.5),
              border: OutlineInputBorder(gapPadding: 0),
              labelText: 'Assign'),
          child: buildFutureWidget(
            Obx(() => DropdownButton<MemberModel>(
                value: assignee.value,
                isExpanded: true,
                onChanged: (value) {
                  assignee.value = value;
                },
                underline: Container(),
                hint: Text('Assignee'),
                items: controller.members
                    .map((e) => DropdownMenuItem<MemberModel>(
                        value: e, child: Text(e.user.email)))
                    .toList())),
          ),
        ));
  }

  Widget _buildOKBtn() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ElevatedButton(
              onPressed: () async {
                await controller.addTask(_buildTaskModel());
                Get.back();
              },
              child: buildFutureWidget(Text('OK'))),
        )),
      ],
    );
  }

  TaskModel _buildTaskModel() {
    return TaskModel(
      title: _titleTxtController.text,
      description: _descTxtController.text,
      startDate: _startDate,
      dueDate: _dueDate,
      status: _status.stringValue(),
      assigneeUserID: assignee.value.user.id,
      statusChangedDate: DateTime.now(),
    );
  }

  Widget _buildTxtFormField(String lable, TextEditingController txtController,
      {TextInputType inputType = TextInputType.text,
      int maxLines = 100,
      int minLines = 1,
      Function onClicked,
      bool isReadOnly = false,
      TextInputAction inputAction = TextInputAction.next}) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: TextFormField(
        textInputAction: inputAction,
        keyboardType: inputType,
        maxLines: maxLines,
        minLines: minLines,
        autofocus: true,
        controller: txtController,
        onTap: onClicked,
        readOnly: isReadOnly,
        showCursor: true,
        decoration: InputDecoration(
            labelText: lable, border: OutlineInputBorder(gapPadding: 0)),
      ),
    );
  }

  Widget _buildTaskStatusChoiceChips() {
    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding),
      child: ChoiChips<TaskStatus>(
          values: TaskStatus.values,
          onSelected: (selected) => _status = selected,
          lables: TaskStatus.values.map((e) => e.stringValue()).toList()),
    );
  }
}
