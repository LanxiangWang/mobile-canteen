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
    _menus.add(new MenuObject('Chinese Style Pork Rib', "Chef Wang's special",
        'assets/pork_rib.jpeg'));
    _menus.add(new MenuObject('Rib-Eye', "For Sihan", 'assets/beef.jpeg'));
    _menus.add(new MenuObject(
        'Chinese Style Fish', "You said it tastes good", 'assets/fish.jpeg'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Column(children: _menus.map((each) => MenuItem(each)).toList());
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Menu"),
      ),
      body: SingleChildScrollView(child: Column(children: _menus.map((each) => MenuItem(each)).toList()),),
      bottomNavigationBar: BottomBar(),
    );
  }
}
