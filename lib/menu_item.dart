import 'package:flutter/material.dart';
import './menu.dart';
import './dish_detail.dart';
import './vendor_item.dart';

class MenuItem extends StatelessWidget {
  final MenuObject _menu;
  final bool _isForProfile;


  MenuItem(this._menu, this._isForProfile);
  

  void navigateToItem(BuildContext context) {}

  Row getSubtitle() {
    if (!_isForProfile) {
      return Row(
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

    return Row(
            children: <Widget>[
              Container(
                width: 200.0,
                child: Text(
                  'Quality: 1',
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
          subtitle: getSubtitle(),
          trailing: getTrailing(context),
          // Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30.0),
        ),
      ),
    );

    // return Text(_menu.name);
  }
}
