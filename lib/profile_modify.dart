import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileModify extends StatefulWidget {
  String userName;
  String phoneNumber;
  Function callback;

  ProfileModify(this.userName, this.phoneNumber, this.callback);

  @override
  State<StatefulWidget> createState() {
    return _ProfileModifyState();
  }
}

class _ProfileModifyState extends State<ProfileModify> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  void initState() {
    super.initState();

    _name = widget.userName;
    _phone = widget.phoneNumber;
  }

  void _modifyInfo(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    if (token == null) {
      print('Token not found!');
      return;
    }

    print('token is: $token');

    String url = 'http://35.194.86.100:5000/customers/info';
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": _name,
        "phone": _phone,
        "password": _password,
        "token": token
      }),
    );

    var jsonBody = json.decode(response.body);
    var error = jsonBody['error_msg'];

    if (error == null) {
      
      // modify successfully
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Modify Successfully!"),
            content:
                new Text("Your information is safely saved on the cloud."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  widget.callback(_name, _phone);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Modify Information"),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    onSaved: (String input) {
                      setState(() {
                        _name = input;
                      });
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: _name,
                      labelText: 'Name',
                    ),
                  ),
                  new TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: _phone,
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.datetime,
                    onSaved: (String input) {
                      setState(() {
                        _phone = input;
                      });
                    },
                  ),
                  new TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.note),
                      hintText: '***********',
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (String input) {
                      setState(() {
                        _password = input;
                      });
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.local_dining),
                      hintText: '***********',
                      labelText: 'Confirm Password',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (String input) {
                      setState(() {
                        _confirmPassword = input;
                      });
                    },
                    // inputFormatters: [
                    //   WhitelistingTextInputFormatter.digitsOnly,
                    // ],
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          print('submit');
                          final form = _formKey.currentState;
                          form.save();
                          // print('name: $_name, description: $_description, quantity: $_quantity, ingredients: $_ingredients, price: $_price, image: $_image');
                          // MenuObject tmp = new MenuObject(_name, _description, _image, _ingredients, _quantity, _quantity, 'Sichuan Gourmet', 'Open for order');
                          // widget.callback(tmp);
                          // Navigator.pop(context);

                          _modifyInfo(context);

                        },
                      )),
                ],
              ))),
    );
  }
}
