import 'package:flutter/material.dart';

class TwoLineItem extends StatelessWidget {
  final String firstText, secondText;

  const TwoLineItem({Key key, @required this.firstText, @required this.secondText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(firstText, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, fontFamily: "RobotoSlab-Regular.ttf")),
        Text(secondText, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, fontFamily: "RobotoSlab-Regular.ttf")),
      ],
    );
  }
}