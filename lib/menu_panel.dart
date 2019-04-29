import 'package:flutter/material.dart';
import './menu.dart';
import './menu_item.dart';
import './bottom_bar.dart';
import './vendor_item.dart';
import './vendor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
    var menuUrl = 'http://35.194.86.100:5000/menus/';
    
    http.get(menuUrl).then((response) {
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
      // var error = jsonBody['error_msg'];

      // if (error == null) {
      //   // get request successfully
        
      // }

      // print('***, $jsonBody');
    });

    var vendorUrl = 'http://35.194.86.100:5000/vendors/';
    http.get(vendorUrl).then((response) {
      var jsonBody = json.decode(response.body);
      var vendors = jsonBody['Menu'];
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
    });

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // mock data
    // MenuObject pork = new MenuObject(
    //     'Chinese Style Pork Rib',
    //     "Chef Wang's special",
    //     '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',
    //     'Tofu, Vegatable Oil, Chinese Leek',
    //     10,
    //     20,
    //     'Little Asia',
    //     'Delivering');
    // MenuObject steak = new MenuObject(
    //     'Rib-Eye',
    //     "Special cooked medium rare rib-eye",
    //     'assets/beef.jpeg',
    //     'Butter, Rib-Eye, Vegatable Oil, Onion',
    //     5,
    //     10,
    //     'Union Grill',
    //     'Open for order');
    // MenuObject fish = new MenuObject(
    //     'Chinese Style Fish',
    //     "Chinese style fish cooked with soy sauce",
    //     'assets/fish.jpeg',
    //     'Fish, Soy Sauce, Pepper, Sugar',
    //     0,
    //     3,
    //     'Sichuan Gourmet',
    //     'Out of stock');

    // VendorObject gourmet = new VendorObject(
    //     'Sichuan Gourmet',
    //     '413 S Craig St, Pittsburgh, PA 15213',
    //     'assets/sichuan_gourmet.png',
    //     4.0,
    //     'description',
    //     []);

    // VendorObject asia = new VendorObject(
    //     'Little Aisa',
    //     '413 S Craig St, Pittsburgh, PA 15213',
    //     'assets/little_asia.png',
    //     4.0,
    //     'description',
    //     [pork]);

    // VendorObject grill = new VendorObject(
    //     'Union Grill',
    //     '413 S Craig St, Pittsburgh, PA 15213',
    //     'assets/union_grill.png',
    //     4.0,
    //     '413 S Craig St, Pittsburgh, PA',
    //     [steak]);

    // _menus.add(pork);
    // _menus.add(steak);
    // _menus.add(fish);

    // _vendors.add(gourmet);
    // _vendors.add(asia);
    // _vendors.add(grill);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    


    // return Column(children: _menus.map((each) => MenuItem(each)).toList());
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Menu"),
      ),
      body: Column(
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
      bottomNavigationBar: BottomBar(),
    );
  }
}
