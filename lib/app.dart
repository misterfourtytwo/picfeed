import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'picfeed',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String login;
  String password;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    login = '';
    password = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            initialValue: login,
            onChanged: (newValue) => login = newValue,
          ),
          TextFormField(
            initialValue: password,
            onChanged: (newValue) => password = newValue,
          ),
          FlatButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                print('logging in');
              } else
                print('invalid input');
            },
            child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                color: Colors.blue,
                child: Text('Login')),
          )
        ]),
      ),
    );
  }
}
