import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_flare/smart_flare.dart';
import 'package:nice_button/nice_button.dart';
import 'package:intl/intl.dart';

import 'chcek_success.dart';
import 'checkSuccessTask.dart';

class addTask extends StatefulWidget {
  @override
  addTaskState createState() {
    return new addTaskState();
  }
}

class addTaskState extends State<addTask> {
  String div_selected;
  String std_selected;
  String subject_selected;
  DateTime mydate = DateTime.now().subtract(Duration(days: 1));
  var end_date = DateTime.now().add(Duration(days: 90));
  String selected_date = 'Tap to select date';
  var current_date = DateTime.now();
  TextEditingController _controller = new TextEditingController();
  String mystring = "your selected date";
  SharedPreferences prefs;
  String name, id;
  DateTime dt;
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
        print(selected_date);
        mystring = new DateFormat.yMMMMd("en_US").format(d);
      });
    }
  }
  @override 
  void initState() {
    SharedPreferences.getInstance().then((onValue) {
      setState(() {
        prefs = onValue;
        id = prefs.getString('id');
        name = prefs.getString('name');
      });
    });
    // TODO: implement initState
    super.initState();
  }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold( 
          resizeToAvoidBottomInset: false,
          body:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 30.0),
                      child:InkWell(
                        child: Icon(Icons.arrow_back, size: 30.0,),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                    margin: EdgeInsets.only(left: 10.0, top: 30.0),
                     child:Text("Add your task", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0)), 
                    )
                  ]
                ),
    
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 12.0, top: 20.0),
                  child:Text("Subject", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22.0)), 
                ),
    
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 12.0, right: 20.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('Subjects ').snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData) {
                        return Container(

                        );
                      }
                      else {
                        List<DropdownMenuItem> mysubject_list = [];
                        for(int i = 0; i < snapshot.data.documents.length; i++) {
                          mysubject_list.add(
                            DropdownMenuItem(
                              child: Text(
                                snapshot.data.documents[i]['subject'],
                              ),
                              value: snapshot.data.documents[i]['subject'],
                            )
                          );
                        }
                        return DropdownButton(
                          items: mysubject_list,
                          onChanged: (myvalue) {
                            setState(() {
                              subject_selected = myvalue;
                            });
                            
                          },
                          isExpanded: true,
                          value: subject_selected,
                          hint: Text("Select subject"),
                        );
                      }
                    },
                  )
                ),            
                
                Container(
                  width: MediaQuery.of(context).size.width,    
                  margin: EdgeInsets.only(left: 12.0, top: 10.0),             
                  child:Text("Standard", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22.0)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 12.0, right: 20.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('class').snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData) {
                        return Container(

                        );
                      }
                      else {
                        List<DropdownMenuItem> mydiv_list = [];
                        for(int i = 0; i < snapshot.data.documents.length; i++) {
                          for(int j = 1; j <= snapshot.data.documents[i]['count']; j++) {
                            mydiv_list.add(
                              DropdownMenuItem(
                                child: Text(snapshot.data.documents[i]['Division'] + snapshot.data.documents[i]['Division' + j.toString()],
                                ),
                                value: snapshot.data.documents[i]['Division'] + snapshot.data.documents[i]['Division' + j.toString()],
                              )
                            );
                          }
                        }
                        return DropdownButton(
                          items: mydiv_list,
                          onChanged: (my_value) {
                            setState(() {
                              div_selected = my_value;
                            });                   
                          },
                          isExpanded: true,
                          value: div_selected,
                          hint: Text("Select Standard"),
                        );
                      }
                    },
                  )
                ),
                
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 12.0, top: 10.0),
                  child: Text("Date", style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
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
                  margin: EdgeInsets.only(left: 12.0, top: 20.0),
                  child:Text("Description", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22.0)), 
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 10.0),
                  child: TextFormField(
                    autovalidate: true,
                    autofocus: false,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'What task u want to give',
                      labelText: "Task"
                    )
                  ),
                ),

               Container(
              margin: EdgeInsets.only(top: 30.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: ProgressButton(
                borderRadius: 15.0,
                color: Colors.red,
                defaultWidget: const Text("Add Task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                progressWidget: const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50.0,
                onPressed: () async{
                  int score = await Future.delayed(
                    const Duration(milliseconds: 1000), () => 42);
                   
                      var connectivityResult = await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                        if(selected_date == 'Tap to select date' || _controller.text == "" || subject_selected == null || div_selected == null) {
                        if(selected_date == 'Tap to select date') {
                        
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
                              content: Text("Please enter task details"),
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
                      
                      if(div_selected == null){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please Select standard and division"),
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

                      if(subject_selected == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please select subject"),
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
                      }
                      else{
                        Timestamp ts = Timestamp.fromDate(dt);
                        Timestamp today = Timestamp.fromDate(DateTime.now());
                        String my_division, my_standard;
                        int len = div_selected.length;
                        my_division = div_selected.substring(1, 2);
                        my_standard = div_selected.substring(0, len - 1);
                        var mysnapshot = await Firestore.instance.collection("homework");
                        mysnapshot.document().setData({'Description': _controller.text, 'added_by': name, 'added_on':today, 'deadline': ts, 'div': my_division, 'id': id, 'std':my_standard, 'subject': subject_selected });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => checkSuccessTask(text: 'Your task added Successfully')));
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
            ),

              ],
            )
          ),
        );
        
      }
   
}