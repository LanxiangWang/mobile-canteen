import 'package:flutter/material.dart';
import './menu.dart';
import './bottom_bar.dart';
import './modal.dart';

class DishDetailPanel extends StatefulWidget {
  MenuObject _menu;

  DishDetailPanel(this._menu);

  @override
  State<StatefulWidget> createState() {
    return _DishDetailPanelState();
  }
}

TextStyle getCorrectStyle(String status) {
  if (status == 'Delivering') {
    return TextStyle(color: Colors.blue);
  } else if (status == 'Open for order') {
    return TextStyle(color: Colors.green);
  } else {
    return TextStyle(color: Colors.red);
  }
}

class _DishDetailPanelState extends State<DishDetailPanel> {
  Modal modal = new Modal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._menu.name),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Image.asset(widget._menu.imgUrl),
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
                            'Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Ingredients: ${widget._menu.ingredients}',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Description: ${widget._menu.description}',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Remaining: ${widget._menu.remain}',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Vendor: ${widget._menu.vendor}',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Status: ',
                                  ),
                                  Text(
                                    widget._menu.status,
                                    style: getCorrectStyle(widget._menu.status),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                  MaterialButton(
                    height: 50.0,
                    minWidth: 300.0,
                    child: Text("Order Now!"),
                    onPressed: () => modal.mainBottomSheet(context),
                    // onPressed: () => modal.mainBottomSheet(context),
                    color: Colors.green[300],
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
