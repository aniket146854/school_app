import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/calendar.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:myproject/main.dart';
import 'package:smart_flare/smart_flare.dart';

import 'homepage.dart';

class checkSuccessTask extends StatelessWidget {
  final String text;
  checkSuccessTask({Key key,@required this.text}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        
        child: FlareActor(
          "assets/check_animation.flr", alignment: Alignment.center, fit:BoxFit.contain, animation: "Untitled", 
          callback: (onValue) {
            Fluttertoast.showToast(
              msg: this.text,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        )
      )
    );
  }
}