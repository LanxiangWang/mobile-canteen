import 'package:flutter/material.dart';
import './menu.dart';
import './dish_detail.dart';
import './vendor_item.dart';
import 'dart:convert';

class MenuItem extends StatelessWidget {
  final MenuObject _menu;
  final bool _isForProfile;


  MenuItem(this._menu, this._isForProfile);
  

  void navigateToItem(BuildContext context) {}

  Column getSubtitle() {
    if (!_isForProfile) {
      return Column(
            children: <Widget>[
              Container(
                width: 200.0,
                child: Text(
                  _menu.status,
                  style: VendorItem.getTextStyle(_menu.status == 'Open for order' ? 'Open for order' : 'Not Available'),
                ),
              )
            ],
          );
    }

    return Column(
            children: <Widget>[
              Container(
                width: 300.0,
                child: Text(
                  'total supply: ${_menu.total}',
                ),
              ),
              Container(
                width: 300.0,
                child: Text(
                  'remaining: ${_menu.remain}',
                ),
              )
            ],
          );
  }

  IconButton getTrailing(BuildContext context) {
    if (!_isForProfile) {
      return IconButton(
            icon: Icon(Icons.keyboard_arrow_right,
                color: Colors.blue, size: 30.0),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DishDetailPanel(_menu)));
            },
          );
    }

    return null;
  }

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
            child: Image.memory(
              base64Decode(_menu.imgUrl),
              width: 60.0,
              height: 60.0,
            ),
          ),
          title: Text(
            _menu.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: getSubtitle(),
          trailing: getTrailing(context),
          // Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30.0),
        ),
      ),
    );

    // return Text(_menu.name);
  }
}
