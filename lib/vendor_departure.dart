import 'package:flutter/material.dart';

class VendorDeparture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VendorDepartureState();
  }
}

class _VendorDepartureState extends State<VendorDeparture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("hello");
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
          ],
        ),
      ),
    );
  }
}
