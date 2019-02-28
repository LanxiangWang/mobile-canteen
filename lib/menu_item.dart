import 'package:flutter/material.dart';
import './menu.dart';

class MenuItem extends StatelessWidget {
  final MenuObject _menu;

  MenuItem(this._menu);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white70),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.blue),
              ),
            ),
            child: Image.asset(
              _menu.imgUrl,
              width: 50.0,
              height: 50.0,
            ),
          ),
          title: Text(
            _menu.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(
                _menu.description,
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30.0),
        ),
      ),
    );

    // return Text(_menu.name);
  }
}
