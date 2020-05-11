import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

List selectedValues;
class addNotice extends StatefulWidget {
  @override
  addNoticeState createState() {
    return new addNoticeState();
  }
}

class addNoticeState extends State<addNotice> {
  String _value;
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: GradientAppBar(
        title: 'Add Notice',
        gradientBegin: Colors.pinkAccent,
        gradientEnd: Colors.purple,
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
          child: Column(
          children:<Widget>[
            Container(
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Text("From", style: TextStyle(fontSize: 20.0, color: Colors.grey,)),
                  ),
                  Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0, top: 3.0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: "Vikas Singh" ,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    )
                  )),
                ]
              )
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Text("To  ", style: TextStyle(fontSize: 20.0, color: Colors.grey,)),
                  ),
                  Expanded(
                  child: Container(
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('class').snapshots(),
                      builder: (context, snapshot) {
                      if(snapshot.hasData) {
                      List<dynamic> mylist = new List<dynamic>();
                      int count = 1;
                      for(int i = 0; i < snapshot.data.documents.length; i++) {
                        Map<String, String> mymap = new Map<String, String>();
                        mymap["display"] = snapshot.data.documents[i]['Division'];
                        mymap["value"] = count.toString();
                        mylist.add(mymap);
                        count++;
                        for(int j = 1; j <= snapshot.data.documents[i]['count']; j++) {
                           Map<String, String> mymap = new Map<String, String>();
                          mymap["display"] = snapshot.data.documents[i]['Division'] + " " + snapshot.data.documents[i]['Division' + j.toString()];
                          mymap["value"] = count.toString();
                          mylist.add(mymap);
                          count++;
                        }
                      }
                    
                      return MultiSelect(
                      autovalidate: true,
                      titleText: "--Select one or more--",
                      validator: (value) {
                        if (value == null) {
                          return 'Please select one or more option(s)';
                        }
                      },
                      errorText: 'Please select one or more option(s)',
                      dataSource: mylist,
                      textField: 'display',
                      valueField: 'value',
                      filterable: true,
                      required: true,
                      value: null,
                      change: (values) {
                        selectedValues = values;
                        print(selectedValues);
                      },
                    );}
                    })
                  )),
                  
                ]
              )),
              Container(
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Text("Subject", style: TextStyle(fontSize: 20.0, color: Colors.grey,)),
                  ),
                  Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0, top: 3.0),
                    child: TextFormField(
                      
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Enter your subject",
                      ),
                    )
                  )),
                ]
              )
            ),
            
            SingleChildScrollView(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Write Description",
                  ),
                )
              ),              
          ]
        )
      ),
    );
  }
}

sendNotice() {
  print(selectedValues);
}