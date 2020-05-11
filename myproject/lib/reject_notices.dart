import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';

class rejectNotice extends StatefulWidget {
  @override
  rejectNoticeState createState() {
    return new rejectNoticeState();
  }
}

class rejectNoticeState extends State<rejectNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: GradientAppBar(
        title: 'Rejected Notices',
        gradientBegin: Colors.orange,
        gradientEnd: Colors.red,
      ),
      body:Center(
        child: Text("rejectd Notices page!"),
      ),
    );
    
  }
}