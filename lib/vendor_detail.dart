import 'package:flutter/material.dart';
import './vendor.dart';
import './bottom_bar.dart';
import './menu_item.dart';

class VendorDetail extends StatelessWidget {
  VendorObject _vendor;

  VendorDetail(this._vendor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_vendor.name),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Image.asset('assets/sichuan_gourmet.png'),
                  ),
                  Card(
                    margin: EdgeInsets.only(bottom: 12.0),
                    elevation: 8.0,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white70),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          title: Text(
                            _vendor.description ?? '',
                          ),
                          subtitle: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Rating: ${_vendor.rating}',
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                            border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.blue),
                            ),
                          ),
                          child: Icon(
                            Icons.local_dining,
                            color: Colors.white,
                          )),
                      title: Text(
                        "Today's Offering",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      // Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30.0),
                    ),
                  ),
                  Column(
                    children: _vendor.todayOffering
                        .where((each) => each.vendor == _vendor.name)
                        .map((each) => MenuItem(each, false))
                        .toList(),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 12.0),
                    child: Image.asset('assets/map.png'),
                  ),
                ],
              ),
            ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
