import 'package:flutter/material.dart';
import './menu.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddDishPage extends StatefulWidget {
  final Function callback;

  AddDishPage(this.callback);

  @override
  State<StatefulWidget> createState() {
    return _AddDishPageState();
  }
}

class _AddDishPageState extends State<AddDishPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  num _quantity = 0;
  num _price = 0;
  String _image = '';
  String _ingredients = '';


  void _choosePic() async {
    File _tmp = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_tmp == null) {
      print('file is null');
      return;
    }
    String base64Image = base64Encode(_tmp.readAsBytesSync());
    print('base64: $base64Image');
    setState(() {
      _image = base64Image;
    });
  }

  void _addDish() async {
    var url = 'http://192.168.0.15:5000/login/';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');

    print('found token: $_token');

    if (_token == null) {
      print('!!! No token was found!');
      return;
    }

    // var response = await http.post(
    //   url,
    //   headers: {"Content-Type": "application/json"},
    //   body: json.encode({
    //     "name": _name,
    //     "description": _description,
    //     "quantity": _quantity,
    //     "price": _price,
    //     "image": _image,
    //     "ingredients": _ingredients,
    //     "token": _token
    //   }),
    // );

    // var jsonBody = json.decode(response.body);
    // var error = jsonBody['error_msg'];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Dish"),
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
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.menu),
                      hintText: 'Enter the name of the dish',
                      labelText: 'Name',
                    ),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.note),
                      hintText: 'Enter the description of the dish',
                      labelText: 'Description',
                    ),
                    keyboardType: TextInputType.datetime,
                    onSaved: (String input) {
                      setState(() {
                        _description = input;
                      });
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.note),
                      hintText: 'Enter the ingredients of the dish',
                      labelText: 'Ingredients',
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (String input) {
                      setState(() {
                        _ingredients = input;
                      });
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.local_dining),
                      hintText: 'Enter how many dishes would you provide',
                      labelText: 'Quantity',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (String input) {
                      setState(() {
                        _quantity = int.parse(input);
                      });
                    },
                    // inputFormatters: [
                    //   WhitelistingTextInputFormatter.digitsOnly,
                    // ],
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.attach_money),
                      hintText: 'Enter the price of the dish',
                      labelText: 'Price',
                    ),
                    onSaved: (String input) {
                      _price = int.parse(input);
                    },
                    // keyboardType: TextInputType.,
                  ),
                  new RaisedButton(
                    onPressed: () {
                      _choosePic();
                    },
                    child: Text('Upload'),
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
                          print('name: $_name, description: $_description, quantity: $_quantity, ingredients: $_ingredients, price: $_price, image: $_image');
                          // MenuObject tmp = new MenuObject(_name, _description, _image, _ingredients, _quantity, _quantity, 'Sichuan Gourmet', 'Open for order');
                          // widget.callback(tmp);
                          // Navigator.pop(context);

                          _addDish();

                        },
                      )),
                ],
              ))),
    );
  }
}
