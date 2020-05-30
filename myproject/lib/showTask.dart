import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:myproject/main.dart';
import 'package:smart_flare/smart_flare.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import 'package:intl/intl.dart';

class showTask extends StatelessWidget {
  String subject, task, division;
  Timestamp deadline;
  showTask({Key key, @required this.subject, @required this.task, @required this.division, @required this.deadline}) : super(key: key);
  bool descTextShowFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5.0, top: 30.0),
                    child: InkWell(
                      child: Icon(Icons.arrow_back, size: 30.0, color: Colors.black),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0, top: 30.0),
                    child: Text(subject, style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black),),
                  )
                  ),
                ],
              
              )
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text("Task:", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.green),),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: ReadMoreText(task),
            ),
  
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text("Sent To:", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.green),),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text(division, style: TextStyle(fontSize: 20.0,  color: Colors.black),),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text("Deadline: ", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.green),),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text(getDate(deadline), style: TextStyle(fontSize: 20.0,  color: Colors.black),),
            ),

          ],
        )
      ),
      floatingActionButton:FloatingActionButton.extended(
          backgroundColor: Colors.green,
          icon: Icon(Icons.check),
          label: Text("Done Reading"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
      )
    );
  }
  
  String getDate(Timestamp deadline) {
    DateTime dt = deadline.toDate();
    String selected_date = new DateFormat.yMMMMd("en_US").format(dt);
    return selected_date;
  }
}