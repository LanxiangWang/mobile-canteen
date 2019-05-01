import 'package:flutter/material.dart';
import './add_dish.dart';
import './menu.dart';
import './menu_item.dart';
import './utils.dart' as utils;
import 'package:shared_preferences/shared_preferences.dart';
import './order_management.dart';

class VendorDeparture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VendorDepartureState();
  }
}

enum DeliverStatus { Prepare, OnTheWay, Arrive }

class _VendorDepartureState extends State<VendorDeparture> {
  List<MenuObject> _list = [];
  List<DataRow> _rows = [];
  DeliverStatus _deliverStatus = DeliverStatus.Prepare;
  List<MenuObject> _todayMenus = [];

  void initState() {
    super.initState();

    _initUpdate();
  }

  void _initUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    String url = 'http://${utils.host}/vendors/menus?token=$token';
    utils.sendRequest(url, 'GET', null).then((res) {
      var jsonBody = utils.getJsonResponse(res);
      var menus = jsonBody['Menu'];
      for (var menu in menus) {
        String image = menu['image_data'];
        String name = menu['name'];
        String ingredients = menu['ingredients'];
        String description = menu['description'];
        num dishId = menu['dish_id'];
        MenuObject _tmp = new MenuObject(name, description, image, ingredients, 0, 0, 10, '', '', dishId);
        setState(() {
          _todayMenus.add(_tmp);  
        });
        
      }

    });
  }

  void updateList(MenuObject menu) {
    setState(() {
      _list.add(menu);
      _rows.add(DataRow(cells: getDataCell(menu)));
    });
  }

  List<DataRow> getDataRow() {
    List<DataRow> rows = [];
    _list.map((each) {
      rows.add(DataRow(cells: getDataCell(each)));
    });
    return rows;
  }

  List<DataCell> getDataCell(MenuObject menu) {
    List<DataCell> cells = [];
    cells.add(DataCell(Text(menu.name)));
    cells.add(DataCell(Text((menu.total - menu.remain).toString())));
    return cells;
  }

  String getCorrectDeliverText() {
    switch (_deliverStatus) {
      case DeliverStatus.Prepare:
        return 'Go';
      case DeliverStatus.OnTheWay:
        return 'Arrive';
      case DeliverStatus.Arrive:
        return 'Complete';
      default:
        return 'Go';
    }
  }

  void updateStatus() {
    switch (_deliverStatus) {
      case DeliverStatus.Prepare:
        setState(() {
          _deliverStatus = DeliverStatus.OnTheWay;
        });
        break;
      case DeliverStatus.OnTheWay:
        setState(() {
          _deliverStatus = DeliverStatus.Arrive;
        });
        break;
      case DeliverStatus.Arrive:
        setState(() {
          _deliverStatus = DeliverStatus.Prepare;
          _list.clear();
          _rows.clear();
        });
        break;
      default:
        
    }
  }

  MaterialColor getColor() {
    switch (_deliverStatus) {
      case DeliverStatus.Prepare:
        return Colors.green;
      case DeliverStatus.OnTheWay:
        return Colors.orange;
      case DeliverStatus.Arrive:
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('test: $_list');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDishPage(updateList)));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Today' Plan"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  // padding: EdgeInsets.only(right: 12.0),
                  margin: EdgeInsets.symmetric(),
                  width: 200,
                  decoration: new BoxDecoration(
                    border: new Border(
                      bottom: new BorderSide(width: 3.0, color: Colors.blue),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Today's Menu",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
            ),
            Column(
              children: _todayMenus.map((ele) => MenuItem(ele, true)).toList(),
              // children: <Widget>[
              //   Text('wuwuw'),
              // ],
            ),
            Center(
              child: Container(
                  // padding: EdgeInsets.only(right: 12.0),
                  margin: EdgeInsets.only(top: 30),
                  width: 200,
                  decoration: new BoxDecoration(
                    border: new Border(
                      bottom: new BorderSide(width: 3.0, color: Colors.blue),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Order Management",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
            ),
            RaisedButton(
            // padding: const EdgeInsets.all(8.0),
            padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderManagement()));
            },
            child: new Text("Check"),
          ),
            InkWell(
              onTap: updateStatus,
              child: new Container(
                width: 150.0,
                height: 150.0,
                margin: EdgeInsets.only(top: 100),
                decoration: new BoxDecoration(
                  color: getColor(),
                  border: new Border.all(color: Colors.white, width: 2.0),
                  borderRadius: new BorderRadius.circular(100.0),
                ),
                child: new Center(
                  child: new Text(
                    getCorrectDeliverText(),
                    style: new TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ListTile myRowDataIcon(IconData iconVal, String rowVal) {
  return ListTile(
    leading: Icon(iconVal, color: Colors.blue),
    title: Text(rowVal),
  );
}
