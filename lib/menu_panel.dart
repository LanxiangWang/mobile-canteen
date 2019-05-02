import 'package:flutter/material.dart';
import './menu.dart';
import './menu_item.dart';
import './bottom_bar.dart';
import './vendor_item.dart';
import './vendor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import "package:pull_to_refresh/pull_to_refresh.dart";

class MenuPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuPanelState();
  }
}


class _MenuPanelState extends State<MenuPanel> {
  List<MenuObject> _menus = [];
  List<VendorObject> _vendors = [];
  bool _isChosenDish = true;
  String _testByte;

  @override
  void initState() {
    super.initState();

    _updateState();
  }

  Future<void> _updateState() async {
    print('update');

    setState(() {
      _menus = [];
      _vendors = [];
    });

    var menuUrl = 'http://35.194.86.100:5000/menus/';
    
    var response = await http.get(menuUrl);
    var jsonBody = json.decode(response.body);
    var menus = jsonBody['Menu'];
    for (var menu in menus) {
      String name = menu['name'];
      String description = menu['description'];
      String image = menu['image_data'];
      String ingredients = menu['ingredients'];
      num price = menu['price'];
      int amountLeft = menu['amount_left'];
      int amount = menu['amount'];
      String vendorName = menu['vendor_name'];
      int dishId = menu['dish_id'];
      
      setState(() {
        MenuObject temp = new MenuObject(name, description, image, ingredients, amountLeft, amount, price, vendorName, amountLeft > 0 ? 'Open for order' : 'Not available', dishId);
        _menus.add(temp);
      });
      print('***, $name');
    }
    

    var vendorUrl = 'http://35.194.86.100:5000/vendors/';
    var responseVendor = await http.get(vendorUrl);
    var jsonBodyVendor = json.decode(responseVendor.body);
    var vendors = jsonBodyVendor['Menu'];
    for (var vendor in vendors) {
      String name = vendor['name'];
      String description = vendor['description'];
      String image = vendor['image'];
      String location = vendor['location'];
      String status = vendor['status'];
      
      setState(() {
        VendorObject tmp = new VendorObject(name, location, image, 5.0, description, _menus);
        _vendors.add(tmp);
      });
    }

    return Future(() => print('updated!'));

  }

  @override
  Widget build(BuildContext context) {
    


    // return Column(children: _menus.map((each) => MenuItem(each)).toList());
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Menu"),
      ),
      body: RefreshIndicator(
        child: ListView(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  // padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: _isChosenDish ? Colors.blue : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _isChosenDish = true;
                    });
                  },
                  child: new Text("Dishes"),
                ),
                new RaisedButton(
                  onPressed: () {
                    setState(() {
                      _isChosenDish = false;
                    });
                  },
                  textColor: Colors.white,
                  color: _isChosenDish ? Colors.grey : Colors.blue,
                  // padding: const EdgeInsets.all(8.0),
                  child: new Text("Vendors"),
                ),
              ],
            ),
            SingleChildScrollView(
              child: _isChosenDish
                  ? Column(
                      children: _menus.map((each) => MenuItem(each, false)).toList())
                  : Column(
                      children: _vendors.map((each) => VendorItem(each)).toList())
            ),
          ],
        ),
        onRefresh: _updateState,
      ),
      
      
      
      bottomNavigationBar: BottomBar(),
    );
  }
}
