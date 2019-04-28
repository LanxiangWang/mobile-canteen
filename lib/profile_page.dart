import 'package:flutter/material.dart';
import './bottom_bar.dart';
import './modal.dart';
import './menu.dart';
import './menu_item.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
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

class _ProfilePageState extends State<ProfilePage> {
  Modal modal = new Modal();

  String userName;
  String phoneNumber;

  MenuObject fish = new MenuObject(
        'Chinese Style Fish',
        "Chinese style fish cooked with soy sauce",
        'assets/fish.jpeg',
        'Fish, Soy Sauce, Pepper, Sugar',
        0,
        3,
        'Sichuan Gourmet',
        'Out of stock');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'User Information',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white70),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                            border: new Border(
                              right: new BorderSide(width: 1.0, color: Colors.blue),
                            ),
                          ),
                          child: Image.asset(
                            'assets/beef.jpeg',
                            width: 50.0,
                            height: 50.0,
                          ),
                        ),
                        title: Text(
                          'Lanxinag Wang',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: Text(
                                '979-739-8647'
                              ),
                            )
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit,
                              color: Colors.blue, size: 30.0),
                          onPressed: () {
                            print('edit');
                          },
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Open Order',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  MenuItem(fish, true),
                ],
              ),
            ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
