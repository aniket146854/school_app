import 'package:flutter/material.dart';

class ProfileInfoBigCard extends StatelessWidget {
  final String firstText, secondText;
  final Widget icon;

  const ProfileInfoBigCard({Key key, @required this.firstText, @required this.secondText, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 16,
          bottom: 24,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: icon,
            ),
            Text(firstText, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, fontFamily: "RobotoSlab-Regular.ttf")),
            Text(secondText, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, fontFamily: "RobotoSlab-Regular.ttf")),
          ],
        ),
      ),
    );
  }
}