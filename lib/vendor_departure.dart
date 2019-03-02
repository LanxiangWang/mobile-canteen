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
      appBar: AppBar(
        title: Text("Today' Plan"),
      ),
      body: Text('placeholder'),
    );
  }
}