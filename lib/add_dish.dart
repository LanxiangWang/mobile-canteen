import 'package:flutter/material.dart';
import './menu.dart';

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
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.picture_in_picture),
                      hintText: 'Upload image of the dish',
                      labelText: 'Image',
                    ),
                    onSaved: (String input) {
                      setState(() {
                        _image = input;
                      });
                    },
                    // keyboardType: TextInputType.,
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
                          print('name: $_name, description: $_description, quantity: $_quantity');
                          MenuObject tmp = new MenuObject(_name, _description, _image, _ingredients, _quantity, 'Sichuan Gourmet', 'Open for order');
                          widget.callback(tmp);
                          Navigator.pop(context);
                        },
                      )),
                ],
              ))),
    );
  }
}
