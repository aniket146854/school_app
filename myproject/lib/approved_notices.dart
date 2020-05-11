import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';

class approveNotice extends StatefulWidget {
  @override
  approveNoticeState createState() {
    return new approveNoticeState();
  }
}

class approveNoticeState extends State<approveNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: GradientAppBar(
        title: 'Approved Notices',
        gradientBegin: Colors.teal,
        gradientEnd: Colors.green,
      ),
      body:Center(
        child: Text("Approved Notices page!"),
      ),
    );
    
  }
}