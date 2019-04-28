import 'package:flutter/material.dart';
import './menu_panel.dart';
import './vendor_departure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;
  String _errorMessage;
  bool _isCustomer = true;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("here return true");
      return true;
    }
    print("here return false");
    return false;
  }

  void _testSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String userName = prefs.getString('userName');
    print('token is $token');
    print('email is $userName');
  }

  void _saveTokenAndUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '306StartUpToken');
    await prefs.setString('userName', _email);
  }

  // return token
  Future<String> _loginAuth(String phone, String password, String name) async {
    var url = 'http://192.168.0.15:5000/login/';
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "phone": phone,
        "name": name,
        "type": _isCustomer ? 'customer' : 'vendor',
        "password": password
      }),
    );

    var jsonBody = json.decode(response.body);
    var error = jsonBody['error_msg'];
    if (error == null) {
      var token = jsonBody['token'];
      return Future(() => token);
    }

    return Future(() => "");
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      // _isLoading = true;
    });
    if (_validateAndSave()) {
      String token = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          // userId = await widget.auth.signIn(_email, _password);
          // print('Signed in: $userId');

          token = await _loginAuth(_email, _password, _name);


          // if login failed
          if (token == "") {
            setState(() {
              _errorMessage = "Invalid username or password";
            });

            return;
          }

          // _testSharedPreference();

          // if login successfully
          _saveTokenAndUserName();




          if (_isCustomer) {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPanel()));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                      builder: (context) => VendorDeparture()));
          }
        } else {
          // userId = await widget.auth.signUp(_email, _password);
          // widget.auth.sendEmailVerification();

          // String url = '';
          // var response = await http.post(url, body: {
          //   'email': _email,
          //   'password': _password
          // });

          // print('response is: $response');




          _showVerifyEmailSentDialog();
          
        }
        // setState(() {
        //   _isLoading = false;
        // });

        // if (userId.length > 0 &&
        //     userId != null &&
        //     _formMode == FormMode.LOGIN) {
        //   widget.onSignedIn();
        // }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Sign In / Sing Up'),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showChoice(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showChoice() {
    return Container(
      margin: EdgeInsets.only(top: 300.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            padding: const EdgeInsets.all(8.0),
            textColor: Colors.white,
            color: _isCustomer ? Colors.blue : Colors.grey,
            child: new Text("Customers"),
            onPressed: () {
              setState(() {
                _isCustomer = true;
              });
            },
          ),
          new RaisedButton(
            onPressed: () {
              print('click vendors');
              setState(() {
                _isCustomer = false;
              });
            },
            textColor: Colors.white,
            color: _isCustomer ? Colors.grey : Colors.blue,
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              "Vendors",
            ),
          ),
        ],
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Future<bool> _signUp(phone, username, password) async {
    var url = 'http://192.168.0.15:5000/register/';

    

    String type = _isCustomer ? 'customer' : 'vendor';

    print('phone: $phone, name: $username, password: $password, type: $type');

    var response = await http.post(
      url, 
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "phone": phone,
        "name": username,
        "type": type,
        "password": password
      }),
    );

    var responseBody = json.decode(response.body)['error_msg'];
    
    
    print('***$responseBody');
    
 
    if (responseBody == null) {
      return Future(() => true);
    }

    return Future(() => false);

  }

  void _showVerifyEmailSentDialog() async {
    
    bool isSuccess = await _signUp(_email, _name, _password);

    if (!isSuccess) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Sign up Failed"),
            content:
                new Text("The same phone number has been used"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  _changeFormToLogin();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Congrats!"),
            content:
                new Text("Sign up successfully!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  _changeFormToLogin();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showNameInput(),
              _showPasswordInput(),

              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100.0,
          child: Image.asset('assets/canteen.jpg', width: 300, height: 300,),
        ),
      ),
    );
  }

  Widget _showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Name',
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value) {
          _name = value;
          print('Name is: $_name');
        },
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Phone',
            icon: new Icon(
              Icons.phone,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Phone can\'t be empty' : null,
        onSaved: (value) {
          _email = value;
          print('_email is: $_email');
        },
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}
