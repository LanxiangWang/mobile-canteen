import 'package:flutter/material.dart';
import './vendor.dart';
import './menu.dart';
import './vendor_detail.dart';

class VendorItem extends StatelessWidget {
  final VendorObject _vendor;

  VendorItem(this._vendor);

  void navigateToItem(BuildContext context) {}

  String getDishStatus(List<MenuObject> menus) {
    bool isAvaliable = true;
    for (MenuObject menu in menus) {
      if (menu.status != 'Open for order') {
        isAvaliable = false;
      }
    }
    if (isAvaliable) {
      return "Open for order";
    }
    return "Not accepting orders";
  }

  static TextStyle getTextStyle(String status) {
    if (status == 'Open for order') {
      return TextStyle(color: Colors.green);
    }
    return TextStyle(color: Colors.red);
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
              _vendor.imgUrl,
              width: 50.0,
              height: 50.0,
            ),
          ),
          title: Text(
            _vendor.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Container(
                width: 200.0,
                child: Text(
                  getDishStatus(_vendor.todayOffering),
                  style: getTextStyle(getDishStatus(_vendor.todayOffering)),
                ),
              )
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right,
                color: Colors.blue, size: 30.0),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VendorDetail(_vendor)));
            },
          ),
          // Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30.0),
        ),
      ),
    );

    // return Text(_menu.name);
  }
}
