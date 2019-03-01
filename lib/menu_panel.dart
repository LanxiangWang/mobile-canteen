import 'package:flutter/material.dart';
import './menu.dart';
import './menu_item.dart';
import './bottom_bar.dart';
import './vendor_item.dart';
import './vendor.dart';

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

  @override
  void initState() {
    // mock data
    MenuObject pork = new MenuObject(
        'Chinese Style Pork Rib',
        "Chef Wang's special",
        'assets/pork_rib.jpeg',
        'Tofu, Vegatable Oil, Chinese Leek',
        10,
        'Little Asia',
        'Delivering');
    MenuObject steak = new MenuObject(
        'Rib-Eye',
        "Special cooked medium rare rib-eye",
        'assets/beef.jpeg',
        'Butter, Rib-Eye, Vegatable Oil, Onion',
        5,
        'Union Grill',
        'Open for order');
    MenuObject fish = new MenuObject(
        'Chinese Style Fish',
        "Chinese style fish cooked with soy sauce",
        'assets/fish.jpeg',
        'Fish, Soy Sauce, Pepper, Sugar',
        3,
        'Sichuan Gourmet',
        'Out of order');

    VendorObject gourmet = new VendorObject(
        'Sichuan Gourmet',
        '413 S Craig St, Pittsburgh, PA 15213',
        'assets/sichuan_gourmet.png',
        4.0,
        'description',
        [fish]);

    VendorObject asia = new VendorObject(
        'Little Aisa',
        '413 S Craig St, Pittsburgh, PA 15213',
        'assets/little_asia.png',
        4.0,
        'description',
        [pork]);

    VendorObject grill = new VendorObject(
        'Union Grill',
        '413 S Craig St, Pittsburgh, PA 15213',
        'assets/union_grill.png',
        4.0,
        'description',
        [steak]);

    _menus.add(pork);
    _menus.add(steak);
    _menus.add(fish);

    _vendors.add(gourmet);
    _vendors.add(asia);
    _vendors.add(grill);

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
                    children: _menus.map((each) => MenuItem(each)).toList())
                : Column(
                    children: _vendors.map((each) => VendorItem(each)).toList())
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
