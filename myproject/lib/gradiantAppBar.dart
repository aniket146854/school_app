import 'package:flutter/material.dart';
import 'addNotice.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget{
  final double _preferredHeight = 100.0;
  GlobalKey mykey;
  String title;
  Color gradientBegin, gradientEnd;
  GradientAppBar({this.title, this.gradientBegin, this.gradientEnd}) :
    assert(title != null),
    assert(gradientBegin != null),
    assert(gradientEnd != null);

  @override 
  Widget build(BuildContext context) {
    return Container(
      height: _preferredHeight,
      padding: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:<Color>[
            gradientBegin,
            gradientEnd,
          ]
        )
      ),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Icon(Icons.arrow_back, size: 30.0, color: Colors.white,),
            )
          ),
          Container(
          margin: EdgeInsets.only(left: 20.0),
          child: Text(
            title,
            style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.0,
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            ),
          ),
          ),
          IconButton(
            color: Colors.white,
            iconSize: 30.0,
            key: mykey,
            focusColor: Colors.white.withOpacity(0.8),
            icon: Icon(Icons.send),
            tooltip: "Click to send notice", 
            onPressed: () {
              sendNotice();
            }
          )
        ]
      )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}

