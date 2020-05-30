import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:myproject/approved_notices.dart';
import 'package:myproject/noticeDescription.dart';
import 'package:myproject/reject_notices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'addNotice.dart';

class notice extends StatefulWidget {
  @override
  noticeState createState() {
    return new noticeState();
  }
}
class noticeState extends State<notice> {
  Timestamp t;
  String sender, subject, description;
  SharedPreferences prefs;
  String role;
  String myname, myid;
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
    if(prefs != null ) {
      if(role == "student") {
        return Scaffold(
          
          body: SlidingUpPanel(
            color: Colors.grey[50],
            minHeight: MediaQuery.of(context).size.height * 0.8,
            maxHeight: MediaQuery.of(context).size.height,
            panel: Container(
              child: StreamBuilder(
              stream: Firestore.instance.collection("Notice").where('sendto', whereIn: ['all', '5']).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return Container(

                  );
                }
                else {
                  return Container(
                    margin: EdgeInsets.only(top: 20.0),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int i) => 
                        Container(
                          height: 100.0,
                          child: Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: ListTile(
                            onTap: () { 
                              Navigator.push(context, MaterialPageRoute(builder: (context) => noticeDescription(index: '$i', sender: snapshot.data.documents[i]['name'], subject: snapshot.data.documents[i]['subject'], description: snapshot.data.documents[i]['description'],sendto: snapshot.data.documents[i]['sendto'] , )));},
                            leading: ClipOval(
                              child: Hero(
                                tag: 'Demo Tag' + '$i',
                                child: Image.asset("assets/Aniket.jpg", width: 50.0, height: 50.0,),
                              )      
                            ),
                            title: Text(snapshot.data.documents[i]['name'], overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 18.0),),
                            subtitle: Text(snapshot.data.documents[i]['description'], style: TextStyle(color: Colors.black, fontFamily:"RobotoSlab-Regular.ttf", fontSize: 15.0), overflow: TextOverflow.ellipsis, ),
                            trailing: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Text(getmyDate(snapshot.data.documents[i]['date']), style: TextStyle(color: Colors.grey, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 12.0),),
                                    )
                                  ), 
                                  Expanded(
                                    child: Container(
                                      
                                      child: Text(getmyTime(snapshot.data.documents[i]['date']), style: TextStyle(color: Colors.grey, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 12.0),),
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
              }
            ,)),

            body: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.indigoAccent.withOpacity(0.9),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:<Color>[
                    Colors.indigoAccent,
                    Colors.indigo,
                  ]
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children:<Widget>[
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, left: MediaQuery.of(context).size.width* 0.36),
                    alignment: Alignment.topRight,
                    child: Text("Notices", style: TextStyle(color:Colors.white, fontSize: MediaQuery.of(context).size.height * 0.04, fontFamily: "RobotoSlab-Regular.ttf", fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    color: Colors.transparent,
                    alignment: Alignment.topRight, 
                    margin: EdgeInsets.only(right: 10.0, top: 20.0),
                    child:InkWell(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Image.asset("assets/navigation_image.png",alignment: Alignment.topRight,color: Colors.white,)
                    )
                  ),
                ]
              ),
            ),
            
            
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
        );
        }
        else if(role == "teacher") {
          return Scaffold(
          body: SlidingUpPanel(
            color: Colors.grey[50],
            minHeight: MediaQuery.of(context).size.height * 0.8,
            maxHeight: MediaQuery.of(context).size.height,
            panel: Container(
              child: StreamBuilder(
              stream: Firestore.instance.collection("Notice").snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return Container(

                  );
                }
                else {
                  int count = 0;
                  List<notice_add> myclass = [];
                  
                  for(int i = 0; i < snapshot.data.documents.length; i++) {
                    List<String> names = List.from(snapshot.data.documents[i]['sendto']);
                    Timestamp date = snapshot.data.documents[i]['date'];
                    String description = snapshot.data.documents[i]['description'];
                    String id = snapshot.data.documents[i]['id'];
                    String name = snapshot.data.documents[i]['name'];
                    String subject = snapshot.data.documents[i]['subject'];
                    for(int j = 0; j < names.length; j++) {
                      String value = names.elementAt(j);
                      if((value == 'all' || value == 'teacher' || value == name ) && myid != id) {
                        myclass.add(notice_add(mydate: date, description: description, id: id, name: name, subject: subject, names:names));
                        count = count + 1;
                        break;
                      }
                    }
                  }
                  
                  return Container(
                    margin: EdgeInsets.only(top: 20.0),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: count,
                        itemBuilder: (BuildContext context, int i) => 
                        Container(
                          height: 100.0,
                          child: Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: ListTile(
                            onTap: () { 
                              Navigator.push(context, MaterialPageRoute(builder: (context) => noticeDescription(index: '$i', sender: myclass.elementAt(i).name, subject: myclass.elementAt(i).subject,description: myclass.elementAt(i).description,sendto: myclass.elementAt(i).names,)));},
                            leading: ClipOval(
                              child: Hero(
                                tag: 'Demo Tag' + '$i',
                                child: Image.asset("assets/Aniket.jpg", width: 50.0, height: 50.0,),
                              )      
                            ),
                            title: Text(myclass.elementAt(i).name, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 18.0),),
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
              }
            ,)),

            body: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children:<Widget>[
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, left: MediaQuery.of(context).size.width* 0.36),
                    alignment: Alignment.topRight,
                    child: Text("Notices", style: TextStyle(color:Colors.white, fontSize: MediaQuery.of(context).size.height * 0.04, fontFamily: "RobotoSlab-Regular.ttf", fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    color: Colors.transparent,
                    alignment: Alignment.topRight, 
                    margin: EdgeInsets.only(right: 10.0, top: 20.0),
                    child:InkWell(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Image.asset("assets/navigation.png",alignment: Alignment.topRight, width: 40.0, height: 40.0 ),
                    )
                  ),
                ]
              ),
            ),
            
            
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.red,
            elevation: 10.0,
            overlayColor: Colors.black12,
            overlayOpacity: 0.85,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                backgroundColor:Colors.purpleAccent,
                child: Icon(Icons.add),
                label: "Add new notice",
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => addNotice()));
                }
              ),
              SpeedDialChild(
                backgroundColor:Colors.greenAccent,
                child: Icon(Icons.check),
                label: "Approved notices",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => approveNotice()));
                }
              ),
              SpeedDialChild(
                backgroundColor:Colors.redAccent,
                child: Icon(Icons.cancel),
                label: "Rejected notices",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => rejectNotice()));
                }
              )
            ]
          ),
        );
        }
      }
      else {
        return Scaffold(
          body: Center(
          child: CircularProgressIndicator(
          backgroundColor: Colors.cyan,
          strokeWidth: 5,
        )));
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
  List<String> names;
  notice_add({
    this.mydate,
    this.description,
    this.id,
    this.name,
    this.subject,
    this.names,
  });
}