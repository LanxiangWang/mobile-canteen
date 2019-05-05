import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DishNumber extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DishNumberState();
  }
}

class _DishNumberState extends State<DishNumber> {
  int _currentValue = 1;

  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('amount', 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NumberPicker.integer(
        initialValue: _currentValue,
        minValue: 1,
        maxValue: 10,
        onChanged: (newValue) {
          setState(() {
            _currentValue = newValue;
            SharedPreferences.getInstance().then((prefs) {
              prefs.setInt('amount', newValue);
            });
          });
        }
    );
  }
}
