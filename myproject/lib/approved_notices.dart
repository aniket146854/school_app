import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_flare/smart_flare.dart';
import 'package:intl/intl.dart';
import 'noticeDescription.dart';

class approveNotice extends StatefulWidget {
  @override
  approveNoticeState createState() {
    return new approveNoticeState();
  }
}

class approveNoticeState extends State<approveNotice> {
  FlareController controller;

  String role;
  String myname, myid;
  SharedPreferences prefs;
  @override 
  void initState() {
    SharedPreferences.getInstance().then((onValue) {
      setState(() {
        prefs = onValue;
        role = prefs.getString('role');
        myname = prefs.getString('name');
        myid = prefs.getString('id');
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(myid != null) {
    return Scaffold( 
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Notices sent", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor: Colors.green,
        leading: InkWell(
          child: Icon(Icons.arrow_back, size: 25.0),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body:Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: Firestore.instance.collection('Notice').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Container(
                child: Center(
                  child:CircularProgressIndicator(
                  backgroundColor: Colors.green,
                  strokeWidth: 6.0,
                ))
              );
            }

            else {
              int count = 0;
              List<notice_add> myclass = [];
              String sending = "";
              for(int i = 0; i < snapshot.data.documents.length; i++)    {
                String id = snapshot.data.documents[i]['id'];
                if(myid == id) {
                  List<String> names = List.from(snapshot.data.documents[i]['sendto']);
                  sending = "";
                  for(int j = 0; j < names.length; j++) {
                    sending = sending + names.elementAt(j);
                    if(j != names.length - 1) {
                      sending = sending + ",";  
                    }
                  }
                  Timestamp date = snapshot.data.documents[i]['date'];
                  String description = snapshot.data.documents[i]['description'];
                  String name = snapshot.data.documents[i]['name'];
                  String subject = snapshot.data.documents[i]['subject'];
                  myclass.add(notice_add(mydate: date, description: description, id: id, name: name, subject: subject, sendto: sending, names:names));
                  count = count + 1;
                }
                
              }
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: count,
                    itemBuilder: (BuildContext context, int i) => 
                    Container(
                      height: 80.0,
                      child: Card(
                      elevation: 2.0,
                 
                      child: ListTile(
                        onTap: () { 
                          Navigator.push(context, MaterialPageRoute(builder: (context) => noticeDescription(index: '$i', sender: myclass.elementAt(i).name, subject: myclass.elementAt(i).subject,description: myclass.elementAt(i).description,sendto: myclass.elementAt(i).names,)));},
                        leading: ClipOval(
                          child: Hero(
                            tag: 'Demo Tag' + '$i',
                            child: Image.asset("assets/Aniket.jpg", width: 50.0, height: 50.0,),
                          )      
                        ),
                        title: Text(myclass.elementAt(i).sendto, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 18.0),),
                        subtitle: Text(myclass.elementAt(i).description, style: TextStyle(color: Colors.black, fontFamily:"RobotoSlab-Regular.ttf", fontSize: 15.0), overflow: TextOverflow.ellipsis, ),
                        trailing: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(getmyDate(myclass.elementAt(i).mydate), style: TextStyle(color: Colors.grey, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 12.0),),
                                )
                              ), 
                              Expanded(
                                child: Container(
                                  
                                  child: Text(getmyTime(myclass.elementAt(i).mydate), style: TextStyle(color: Colors.grey, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 12.0),),
                                )
                              ), 

                            ],
                          )
                        ),
                      ),
                    ),)
                ),
              );
            }
          },
        )
      ),
    );}
    else {
      return Container(
        child:Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ),
        )
      );
    }
    
  }
  getmyDate(Timestamp timestamp) {
    var formatter = new DateFormat('dd/MM/yyyy');
    String formatted = formatter.format(timestamp.toDate());
    return formatted;
  }

  getmyTime(Timestamp timestamp) {
    var formatter = new DateFormat('hh:mm');
    String formatted = formatter.format(timestamp.toDate());
    return formatted;
  } 
}

class notice_add {
  Timestamp mydate;
  String description;
  String id;
  String name;
  String subject;
  String sendto;
  List<String> names;
  notice_add({
    this.mydate,
    this.description,
    this.id,
    this.name,
    this.subject, 
    this.sendto,
    this.names,
  });
}