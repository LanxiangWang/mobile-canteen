import 'package:flutter/material.dart';
import './dish_number.dart';

class Modal {
  mainBottomSheet(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(
                  context, 'Please choose count', Icons.local_dining, _action1),
              // _createTile(context, 'Take Photo', Icons.camera_alt, _action2),
              // _createTile(context, 'My Images', Icons.photo_library, _action3),
              DishNumber(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(title: Text("You have placed the order!"),);
                        }
                      );
                    },
                    child: new Text("Order"),
                  ),
                  new RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textColor: Colors.white,
                    color: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Cancel",
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}

ListTile _createTile(
    BuildContext context, String name, IconData icon, Function action) {
  return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action();
      });
}

_action1() {
  print('action 1');
}

_action2() {
  print('action 2');
}

_action3() {
  print('action 3');
}
