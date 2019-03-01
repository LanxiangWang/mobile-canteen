import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DishNumber extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DishNumberState();
  }
}

class _DishNumberState extends State<DishNumber> {
  int _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NumberPicker.integer(
        initialValue: _currentValue,
        minValue: 1,
        maxValue: 10,
        onChanged: (newValue) => setState(() => _currentValue = newValue));
  }
}
