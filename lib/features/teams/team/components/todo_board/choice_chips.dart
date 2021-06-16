import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_todo_app/utils/constants.dart';

class ChoiChips<T> extends StatefulWidget {
  final List<T> values;
  final List<String> lables;
  final Function(T selected) onSelected;

  ChoiChips(
      {@required this.values,
      @required this.lables,
      @required this.onSelected});

  @override
  _ChoiChipsState<T> createState() =>
      _ChoiChipsState<T>(values, lables, onSelected);
}

class _ChoiChipsState<T> extends State<ChoiChips> {
  final List<String> labels;
  final List<T> values;
  final Function(T selected) onSelected;
  final initSelectedIndex = 0;
  T selectedValue;

  _ChoiChipsState(this.values, this.labels, this.onSelected);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:
          List.generate(values.length, (index) => _buildChoiceChip(index)),
    );
  }

  ChoiceChip _buildChoiceChip(int index) {
    return ChoiceChip(
      label: Text(
        labels[index],
        style: TextStyle(color: Colors.black),
      ),
      selected: values[index] == selectedValue ||
          (selectedValue == null && index == initSelectedIndex),
      selectedColor: kPrimarySwatch,
      onSelected: (isSelected) {
        if (isSelected && values[index] != selectedValue) {
          selectedValue = values[index];
          setState(() {});
        }
      },
    );
  }
}
