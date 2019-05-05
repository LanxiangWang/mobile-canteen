import 'package:flutter/material.dart';
import './utils.dart' as utils;
import 'package:shared_preferences/shared_preferences.dart';
import './pick_up_item.dart';
import './utils.dart' as utils;

class OrderManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderManagementState();
  }
}

enum DeliverStatus { Prepare, OnTheWay, Arrive }

class _OrderManagementState extends State<OrderManagement> {
  List<PickUpItem> _list = [];

  void initState() {
    super.initState();


    print('*** init');
    _initUpdate();
  }

  Future<void> _initUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    
    setState(() {
      print('1');
      _list = [];
    });

    String url = 'http://${utils.host}/vendors/orders?token=$token';
    var res = await utils.sendRequest(url, 'GET', null);

    var jsonBody = utils.getJsonResponse(res);
    var orders = jsonBody['Orders'];
    for (var order in orders) {
      if (order['status'] == 'picked up') {
        continue;
      }
      PickUpItem _tmp = new PickUpItem(order, deleteItem);

      setState(() {
        print('2');
        _list.add(_tmp);
      });
    }

    print('done');
  }

  void deleteItem(num orderId) {
    int index = -1;
    for (int i = 0; i < _list.length; i++) {
      if (_list[i].order['order_id'] == orderId) {
        index = i;
      }
    }

    if (index != -1) {
      String url = 'http://${utils.host}/orders/status/';
      utils.sendRequest(url, 'POST', {
        'order_id': orderId,
        'status': 'picked up'
      }).then((res) {
        var jsonBody = utils.getJsonResponse(res);
        if (jsonBody['error_msg'] == null) {
          setState(() {
            _list.removeAt(index);
          });
        }
      });      
    }
  }

  @override
  Widget build(BuildContext context) {
    print('test: $_list');
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Management"),
      ),
      body: RefreshIndicator(
          child: ListView(
            children: <Widget>[
              Column(
                children: _list,
              ),
            ]
          ),
          onRefresh: _initUpdate,
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
