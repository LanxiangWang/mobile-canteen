import 'package:flutter/material.dart';
import './menu.dart';
import './menu_item.dart';
import './bottom_bar.dart';

class MenuPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuPanelState();
  }
}

class _MenuPanelState extends State<MenuPanel> {
  List<MenuObject> _menus = [];

  @override
  void initState() {
    _menus.add(new MenuObject(
        'Chinese Style Pork Rib',
        "Chef Wang's special",
        'assets/pork_rib.jpeg',
        'Tofu, Vegatable Oil, Chinese Leek',
        10,
        'Little Asia',
        'Delivering'));
    _menus.add(new MenuObject(
        'Rib-Eye',
        "Special cooked medium rare rib-eye",
        'assets/beef.jpeg',
        'Butter, Rib-Eye, Vegatable Oil, Onion',
        5,
        'Union Grill',
        'Open for order'));
    _menus.add(new MenuObject(
        'Chinese Style Fish', 
        "Chinese style fish cooked with soy sauce", 
        'assets/fish.jpeg',
        'Fish, Soy Sauce, Pepper, Sugar',
        3,
        'Sichuan Gourmet',
        'Out of order'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Column(children: _menus.map((each) => MenuItem(each)).toList());
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Menu"),
      ),
      body: SingleChildScrollView(
        child: Column(children: _menus.map((each) => MenuItem(each)).toList()),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
