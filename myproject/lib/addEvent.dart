import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addEvent extends StatefulWidget {
  @override
  addEventState createState() {
    return new addEventState();
  }
}

class addEventState extends State<addEvent> {
  DateTime mydate = DateTime.now().subtract(Duration(days: 1));
  String selected_date = 'Tap to select date';
  var current_date = DateTime.now();
  var end_date = DateTime.now().add(Duration(days: 90));
  TextEditingController _controller = new TextEditingController();
  String mystring = "your selected date";
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  DateTime dt;
  // Platform messages are asynchronous, so we initialize in an async method.
  
  Future<void> _selectDate(BuildContext context) async{
    final DateTime d = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: mydate, 
      lastDate: end_date,
    );
    if(d != null) {
      setState(() {
        dt = d;
        selected_date = new DateFormat.yMMMMd("en_US").format(d);
        mystring = new DateFormat.yMMMMd("en_US").format(d);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
     appBar: AppBar(
       title: Text("Add Event", style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
       backgroundColor: Colors.white,
       leading: IconButton(
         icon: Icon(Icons.arrow_back, color: Colors.black,), 
         onPressed: () {
           Navigator.pop(context);
         }
        ),
     ),
    
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 20.0),
              child: Text("Date", style: TextStyle(color: Colors.pink, fontSize: 20.0), textAlign: TextAlign.start,),
            ),

            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.black),
                      left: BorderSide(width: 1.0, color: Colors.black),
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                      right: BorderSide(width: 1.0, color: Colors.black),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:<Widget>[
                        InkWell(
                          child:Text(
                            selected_date,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF000000))
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          tooltip: 'Tap to open date picker', 
                          onPressed: () {
                            _selectDate(context);
                          }
                        )
                      ]
                    ),
                  ),
                )
              ],
            ),),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 20.0),
              child: Text("What is Event?", style: TextStyle(color: Colors.pink, fontSize: 20.0), textAlign: TextAlign.start,),
            ),
            
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 10.0),
              child: TextFormField(
                autovalidate: true,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'What is event on '+ mystring,
                  labelText: "Event"
                )
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 30.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: ProgressButton(
                borderRadius: 10.0,
                color: Colors.pink,
                defaultWidget: const Text("Add Event", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                progressWidget: const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50.0,
                onPressed: () async{
                  int score = await Future.delayed(
                    const Duration(milliseconds: 2000), () => 42);
                   
                      var connectivityResult = await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                        if(selected_date == 'Tap to select date') {
                        print(_connectionStatus);
                        print('Hii');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please Select date"),
                              actions:[
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }
                                )
                              ]
                            );
                          }
                        );
                      }
                      if(_controller.text == "") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please enter event detail"),
                              actions:[
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }
                                )
                              ]
                            );
                          }
                        );
                      }
                      else{
                        Timestamp ts = Timestamp.fromDate(dt);
                        var datasnpshot = await Firestore.instance.collection("events").where('date' , isEqualTo: ts).getDocuments();
                        if(datasnpshot.documents.length == 0) {
                          print("It is not found!");
                        }
                      }
                      
                      } else {
                        Fluttertoast.showToast(
                          msg: "Unable to connect! Please check your internet conneection",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      
    
                },
                
              )
            )
          ],
        )
      )
    );
    
  }
}
