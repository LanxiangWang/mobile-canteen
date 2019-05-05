import 'package:flutter/material.dart';
import './menu.dart';
import './dish_detail.dart';
import './vendor_item.dart';
import 'dart:convert';

class OrderItem extends StatelessWidget {
  var order;

  OrderItem(this.order);

  List<Widget> _getSubtitles() {

    List<Widget> _list = [];
    _list.add(
      Container(
        width: 300.0,
        child: Text(
          'quantity: ${order['quantity'].toString()}',
        ),
      )
    );

    _list.add(
      Container(
        width: 300.0,
        child: Text(
          'vendor: ${order['vendor_name']}',
        ),
      )
    );

    if (order['status'] == 'Not yet') {
      // open orders, showing location
      String _location = order['location'] ?? 'Not Available';

      _list.add(
        Container(
          width: 300.0,
          child: Text(
            'location: $_location',
          ),
        )
      );
    }

    return _list;
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
                  child: Icon(
                    Icons.fastfood,
                    color: Colors.blue, size: 30.0
                  ),
                ),
                title: Text(
                  order['dish_name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  children: _getSubtitles(),
                ),
                // trailing: getTrailing(context),
                // Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30.0),
              ),
            ),
          );

    // return Text(_menu.name);
  }
}
