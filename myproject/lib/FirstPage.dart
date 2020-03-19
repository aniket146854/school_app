import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/login_page.dart';
import 'package:myproject/main.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder:(BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return MyHomePage();
        }
        else {
          return loginPage();
        }
      }
    );
  }
}