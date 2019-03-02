import 'package:flutter/material.dart';
import './add_dish.dart';
import './menu.dart';
import './menu_item.dart';

class VendorDeparture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VendorDepartureState();
  }
}

class _VendorDepartureState extends State<VendorDeparture> {
  List<MenuObject> _list = [];

  void updateList(MenuObject menu) {
    setState(() {
      _list.add(menu);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('test: $_list');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddDishPage(updateList)));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Today' Plan"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  // padding: EdgeInsets.only(right: 12.0),
                  margin: EdgeInsets.symmetric(),
                  width: 200,
                  decoration: new BoxDecoration(
                    border: new Border(
                      bottom: new BorderSide(width: 3.0, color: Colors.blue),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Today's Menu",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
            ),
            Column(
              children: _list.map((ele) => MenuItem(ele)).toList(),
              // children: <Widget>[
              //   Text('wuwuw'),
              // ],
            ),
          ],
        ),
      ),
    );
  }
}
