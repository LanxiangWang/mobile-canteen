import 'package:flutter/material.dart';
import './menu_panel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Canteen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPanel(),
      // home: DishDetailPanel(new MenuObject('Mapo Tofu', 'For Sihan', 'assets/fish.jpeg'))
    );
  }
}