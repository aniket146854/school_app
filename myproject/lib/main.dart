import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myproject/calendar.dart';
import 'package:myproject/homepage.dart';
import 'package:myproject/mypofile.dart';
import 'package:myproject/top_bar.dart';
import 'collapsing_navigation_drawer.dart';
import 'curved_painter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'notice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1)
  };
  MaterialColor colorcustom = MaterialColor(0xFF880E4F, color);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  int pageindex = 0;

  final homepage _myhomepage = homepage();
  final notice _mynoticepage = notice();
  final myprofile _myprofilepage = myprofile();
  final myCalendar _mycalendarpage = myCalendar();

  Widget _showPage = homepage();

  Widget _pagechooser(int page) {
    switch (page) {
      case 0:
        return _myhomepage;
        break;
      
      case 1:
        return _myprofilepage;
        break;
      
      case 2:
        return _mynoticepage;
        break;
      
      case 3:
        return _mycalendarpage;
        break;
      default:
    }
  }
  @override
  Widget build(BuildContext context) { 
     return Scaffold(
      drawer: CollapsingNavigationDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.indigoAccent.withOpacity(0.8),
        buttonBackgroundColor: Colors.white,
        height: 45.0,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        animationCurve: Curves.decelerate,
        items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.people, size: 30),
            Icon(Icons.notifications, size: 30),
            Icon(Icons.list, size: 30),
          ],
          onTap: (tappedIndex) {
            setState(() {
              _showPage = _pagechooser(tappedIndex);
            });
          },          
        ),

        body: Container(
          child:Center(
            child: _showPage,
          )
        ),
        
     );
  }
}
