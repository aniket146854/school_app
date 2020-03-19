import 'package:flutter/material.dart';

class OpaqueImage extends StatelessWidget {
  final imageurl;

  const OpaqueImage({Key key, @required this.imageurl}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget>[
        Image.asset(
          imageurl, width: double.maxFinite, height: double.maxFinite, fit: BoxFit.fill,
        ),

        Container(
          color: Colors.indigoAccent.withOpacity(0.85),
        )
      ]
    );
  }
}