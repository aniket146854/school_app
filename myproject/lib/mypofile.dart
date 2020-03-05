import 'package:flutter/material.dart';

class myprofile extends StatefulWidget {
  @override
  myprofileState createState() {
    return new myprofileState();
  }
}
class myprofileState extends State<myprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text("This is profile page!"),
      ),
    );
  }
}