import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../base/base_get_widget.dart';
import '../../../../../constants/constants.dart';
import '../../../../../utils/utils.dart';
import 'choice_chips.dart';
import 'task/model.dart';
import '../controller.dart';

class UpsertTaskDialog extends BaseGetWidget<TodoBoardController> {
  final TaskModel taskToUpdate;
  final int boardIndex;
  final _titleTxtController = TextEditingController();
  final _descTxtController = TextEditingController();
  final _startDateTxtController = TextEditingController();
  final _dueDateTxtController = TextEditingController();
  String _assigneeUserID;
  TaskStatus _status = TaskStatus.Todo;
  DateTime _startDate, _dueDate;

  UpsertTaskDialog({this.taskToUpdate, this.boardIndex}) {
    if (taskToUpdate != null) {
      _titleTxtController.text = taskToUpdate.title;
      _descTxtController.text = taskToUpdate.description;
      _startDateTxtController.text = formatDate(taskToUpdate.startDate);
      _dueDateTxtController.text = formatDate(taskToUpdate.dueDate);
      _startDate = taskToUpdate.startDate;
      _dueDate = taskToUpdate.dueDate;
      _assigneeUserID = taskToUpdate.assigneeUserID;
    } else {
      _startDate = DateTime.now();
      _dueDate = DateTime.now();
    }
  }

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
          bottomNavigationBar: _buildOKBtn(),
          resizeToAvoidBottomInset: false,
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
          child: buildLoadingObx(
            StatefulBuilder(builder: (context, setState) {
              return DropdownButton<String>(
                  value: _assigneeUserID,
                  isExpanded: true,
                  onChanged: (value) {
                    _assigneeUserID = value;
                    setState(() {});
                  },
                  underline: Container(),
                  hint: Text('Assignee'),
                  items: controller.members
                      .map((e) => DropdownMenuItem<String>(
                          value: e.user.id, child: Text(e.user.email)))
                      .toList());
            }),
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
                if (taskToUpdate != null) {
                  _setTaskInputValues();
                  await controller.updateTask(taskToUpdate, boardIndex);
                } else {
                  await controller.addTask(_buildTaskModel());
                }
                Get.back();
              },
              child: buildLoadingObx(Text('OK'))),
        )),
      ],
    );
  }

  void _setTaskInputValues() {
    taskToUpdate.title = _titleTxtController.text;
    taskToUpdate.description = _descTxtController.text;
    taskToUpdate.startDate = _startDate;
    taskToUpdate.dueDate = _dueDate;
    taskToUpdate.dueDate = _dueDate;
    taskToUpdate.assigneeUserID = _assigneeUserID;
    taskToUpdate.status = _status.stringValue();
  }

  TaskModel _buildTaskModel() {
    return TaskModel(
      title: _titleTxtController.text,
      description: _descTxtController.text,
      startDate: _startDate,
      dueDate: _dueDate,
      status: _status.stringValue(),
      assigneeUserID: _assigneeUserID,
      statusChangedDate: DateTime.now(),
      creatorUserID: controller.appUserID,
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
