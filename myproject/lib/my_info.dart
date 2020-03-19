import 'package:flutter/material.dart';
import 'package:myproject/radial_progress.dart';
import 'package:myproject/rounded_image.dart';

class MyInfo extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
        RadialProgress(
          width: 4.0,
          goalCompleted: 0.9,
            child: RoundedImage(
            imagePath: "assets/Aniket.jpg",
            size: Size.fromWidth(128.0),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Text(
            "Aniket Madam",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize:15.0, fontFamily: "RobotoSlab-Regular.ttf", color:Colors.white),
          ),

          Text(
            "," + "20",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize:15.0, fontFamily: "RobotoSlab-Regular.ttf", color:Colors.white),
          )
        ]),
      ]
    )
  );
  }
}