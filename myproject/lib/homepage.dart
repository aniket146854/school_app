
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_floating_button/draggable_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:myproject/custom_navigation_drawer.dart';
import 'package:myproject/showTask.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addTask.dart';
import 'collapsing_navigation_drawer.dart';
import 'package:intl/intl.dart';
import 'package:imagebutton/imagebutton.dart';

class homepage extends StatefulWidget {
  @override
  homepageState createState() {
    return new homepageState();
  }
}
class homepageState extends State<homepage> {
  String name;
  SharedPreferences prefs;
  String role, id, std, div;
  var day = DateFormat('EEEE').format(DateTime.now());


  @override 
  void initState() {
    SharedPreferences.getInstance().then((onValue) {
      setState(() {
        prefs = onValue;
        id = prefs.getString('id');
        std = prefs.getString('std');
        div = prefs.getString('div');
        role = prefs.getString('role');
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(prefs != null) {
      if(role == 'student') {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 150),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 10,
                  blurRadius: 2
                )]
              ),
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigoAccent.withOpacity(0.9),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                ),
                child: Container(
                    child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 15, top: 40),
                        /*decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            )
                        ),*/
                        child:ClipOval (
                          child: Image.asset("assets/Aniket.jpg", fit: BoxFit.cover, height: 90, width: 90,),),
                      ), 
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 40.0),
                          child: Text( prefs.getString('name'),style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'RobotoSlab-Regular.ttf',fontWeight: FontWeight.bold,),)),
                      ),

                      Container(
                        color: Colors.transparent,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(right: 10.0),
                        width: 80,
                        height: 80,
                        child:InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Image.asset("assets/navigation_image.png", color: Colors.white,)
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child:SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget>[
                      
                      Container(
                        margin: EdgeInsets.only(top: 20.0, left:13.0),
                      child: Text("Your Lectures", style: new TextStyle(fontWeight:FontWeight.bold, fontFamily: "RobotoSlab-Regular.ttf", fontSize: 20.0)),),
                      
                      StreamBuilder(
                        stream: Firestore.instance.collection('/lecture/5 A/Monday').snapshots(),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData) {
                            return Container();
                          }
                          else {
                            return Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text("(" + snapshot.data.documents.length.toString() +")", style: new TextStyle(fontWeight:FontWeight.bold, fontFamily: "RobotoSlab-Regular.ttf", fontSize: 18.0, color:Colors.grey)),);
                        }})
                      ]),
                    Container(
                      margin: EdgeInsets.only(right: 10.0, top: 20.0),
                      child: Text("See All",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "RobotoSlab-Regular.ttf", fontSize: 13.0, color: Colors.grey))),
                  ]
                ),
                
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Expanded (
                      child: Container(
                        margin: EdgeInsets.only(top: 20.0),
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: StreamBuilder(
                          stream: Firestore.instance.collection('/lecture/5 A/Monday').snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.redAccent,
                                  value: 0.2,
                                )
                              );
                            }
                            else {
                              return ListView.builder( 
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (BuildContext context, int i) => 
                                  Card(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.all(15.0),
                                      width: 220,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:<Widget>[
                                          Text(snapshot.data.documents[i]['Subject'], style: TextStyle(fontWeight:FontWeight.bold, fontFamily: "RobotoSlab-Regular.ttf", fontSize: 16,)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(top: 10.0),
                                                  child: Image.asset("assets/clock.png", width: 15, height: 15, color:Colors.blueAccent),),
                                                Container(
                                                  margin: EdgeInsets.only(top:10.0, left:10.0),
                                                
                                                  child: Text(getmyTime(snapshot.data.documents[i]['start']) + " to " + getmyTime(snapshot.data.documents[i]['end']), style: TextStyle(fontFamily: "RobotoSlab-Regular.ttf", fontSize: 15.0),),),
                                                
                                            ],
                                          ),
                                          
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(top: 10.0),
                                                  child: Image.asset("assets/professor.png", width: 20, height: 20, color: Colors.blueAccent,),),
                                                Expanded (
                                                child:Container(

                                                  margin: EdgeInsets.only(top:10.0, left: 10.0),
                                                  child: Text(snapshot.data.documents[i]['Teacher'], style: TextStyle(fontFamily: "RobotoSlab-Regular.ttf", fontSize: 15.0),)),
                                                )
                                            ],
                                          ),
                                        ]
                                      ),
                                    )
                                  ))
                        ;};})),),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20.0, left: 13.0),
                        child: Text("Your Tasks", style: TextStyle(fontSize: 18.0, fontFamily: "RobotoSlab-Regular.ttf", fontWeight:FontWeight.bold))),
                        
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: Text("(6)", style: TextStyle(fontSize: 18.0, fontFamily: "RobotoSlab-Regular.ttf", fontWeight:FontWeight.bold, color: Colors.grey))
                      )
                      ],
                    )
                  ],
                ),

                
                
                Expanded(
                      child:Container(
                      
                      child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child: ListView.builder(
                        
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int i) =>
                        Card(
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          child: Container(
                            height: 80.0,
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:<Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text("Maths", style: TextStyle(fontWeight: FontWeight.bold, fontFamily:"RobotoSlab-Regular.ttf", fontSize: 18.0,),)
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[                                 
                                        Container(
                                          margin: EdgeInsets.only(left:10.0),
                                          child: Image.asset("assets/red_dot.png", fit: BoxFit.cover, height: 11, width: 11, color: Colors.redAccent,),
                                        ),
                                          Container(
                                            margin: EdgeInsets.only(left:3.0),
                                            child: Text("4 days left", style: TextStyle(fontWeight: FontWeight.bold, fontFamily:"RobotoSlab-Regular.ttf", fontSize: 15.0, color:Colors.grey),)
                                        ),
                                      ],
                                    ),
                                    
                                    Container(
                                      margin: EdgeInsets.only(right:10.0),
                                      child: Text("Deadline", style: TextStyle(fontWeight: FontWeight.bold, fontFamily:"RobotoSlab-Regular.ttf", fontSize: 15.0, color:Colors.redAccent),)
                                    )
                                  ],
                                )
                              ]
                            ),
                          )
                        )
                      )
                    ))),
              ]
            ),
          )));}
          else if(role == 'teacher') {
            return Scaffold(
              backgroundColor: Colors.grey[50],
              body:SizedBox(
                height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>[
                        Container(
                          child: Text("Mount Litera School", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.red,))
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: ImageButton(
                            children:<Widget>[], 
                            width: 36.0,
                            height: 36.0,
                            unpressedImage: Image.asset("assets/navigation.png"),
                            pressedImage: Image.asset("assets/navigation.png", color: Colors.red),
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                          )
                        ),
                      ]
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0, left: 10.0),
                    child: Text("Today's Lectures to take", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22.0)),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('/teacher_timetable/' + id + '/1').snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          int count = 0;
                          int value = 0;
                          int flag = 0;
                          for(int i = 0; i < snapshot.data.documents.length; i++) {
                            if(snapshot.data.documents[i]['day'] == day) {
                              value = i;
                              flag = 1;
                              count = snapshot.data.documents[i]['no_lectures'];
                              print('value = ' + value.toString() + "count = " + count.toString());
                            }
                          }
                          if(flag == 0) {
                            return Container(
                              child: Text("No Lectures", textAlign: TextAlign.center, style:TextStyle(fontSize: 20.0, color: Colors.red)),
                            );
                          } 

                          return Container(
                            height: 120.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: count,
                              itemBuilder: (BuildContext context, int i) => 
                              Container(
                              child:Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                              ),
                                child: Container(
                                  
                                  margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.all(15.0),
                                      width: 220,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:<Widget>[
                                          Text(snapshot.data.documents[value]['lecture'+ (i + 1).toString()+ '_subject'], style: TextStyle(fontWeight:FontWeight.bold, fontFamily: "RobotoSlab-Regular.ttf", fontSize: 16,)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(top: 10.0),
                                                  child: Image.asset("assets/clock.png", width: 15, height: 15, color:Colors.blueAccent),),
                                                Container(
                                                  margin: EdgeInsets.only(top:10.0, left:10.0),
                                                
                                                  child: Text(snapshot.data.documents[value]['lecture' + (i + 1).toString()+ '_start'] + " to " + snapshot.data.documents[value]['lecture' + (i + 1).toString()+ '_end'] , style: TextStyle(fontFamily: "RobotoSlab-Regular.ttf", fontSize: 15.0),),),
                                                
                                            ],
                                          ),
                                          
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(top: 10.0),
                                                  child: Image.asset("assets/professor.png", width: 20, height: 20, color: Colors.blueAccent,),),
                                                Expanded (
                                                child:Container(

                                                  margin: EdgeInsets.only(top:10.0, left: 10.0),
                                                  child: Text(snapshot.data.documents[value]['lecture' + (i + 1).toString()+ '_std'], style: TextStyle(fontFamily: "RobotoSlab-Regular.ttf", fontSize: 15.0),)),
                                                )
                                            ],
                                          ),
                                        ]
                                      ),
                                  
                                ),
                              ))
                            )
                          );
                        }
                        else {
                          return Container(
                            child: Text("No Lectures", textAlign: TextAlign.center, style:TextStyle(fontSize: 20.0, color: Colors.red)),
                          );
                        }
                      }
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Text("Tasks you added", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22.0)),
                  ),

                  Expanded(
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('homework').where('id', isEqualTo: id).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {  
                            List<myclass> mylist = [];
                            mylist.clear();
                            for(int i = 0; i < snapshot.data.documents.length; i++) {
                              String subject = snapshot.data.documents[i]['subject'];
                              String description = snapshot.data.documents[i]['Description'];
                              Timestamp ts = snapshot.data.documents[i]['deadline'];
                              String std = snapshot.data.documents[i]['std'].toString() + snapshot.data.documents[i]['div'];
                              mylist.add(myclass(subject: subject, description: description, deadline: ts, division: std));
                            }
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int i) => 
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => showTask(subject: mylist.elementAt(i).subject, task: mylist.elementAt(i).description, deadline: mylist.elementAt(i).deadline, division: mylist.elementAt(i).division)));
                                  },
                                  child:Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child:Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.all(15.0),
                                    height: 110.0,
                                    width: MediaQuery.of(context).size.height,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[                                      
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Text(snapshot.data.documents[i]['subject'],textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              child: Text(snapshot.data.documents[i]['Description'],style: TextStyle(color: Colors.grey, fontSize: 16.0), overflow: TextOverflow.ellipsis),
                                            )
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Text(snapshot.data.documents[i]['std'].toString() + " " + snapshot.data.documents[i]['div'], style: TextStyle(color: Colors.grey, fontSize: 16.0)),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:<Widget>[
                                              Container(
                                                child: Image.asset("assets/red_dot.png", width: 10.0, height: 10.0),
                                              ),
                                              Container(  
                                                margin: EdgeInsets.only(left: 10.0),    
                                                child: Text("Submit by " + getmyDate(snapshot.data.documents[i]['deadline'])  , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.red)),
                                              ),
                                            ]
                                          ),
                                        ],
                                    )
                                  ))
                                )
                              
                            ),
                          );
                        }
                        else {
                          return Container(

                          );
                        }
                      },
                    ),
                  )
                ],
              )
            ),
              floatingActionButton:FloatingActionButton.extended(
                backgroundColor: Colors.red,
                icon: Icon(Icons.add),
                label: Text("Add Task"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => addTask()));
                },
              )
            );
          }
          else if(role == 'principal') {
            return Scaffold(
              body: Center(
                child: Text("This is Principal page!"),
              ),
            );
          }
      }
      else {
        return CircularProgressIndicator(
              backgroundColor: Colors.redAccent,
              value: 0.2,
            );
      }
  }
  getmyTime(Timestamp timestamp) {
    var formatter = new DateFormat('hh:mm a');
    String formatted = formatter.format(timestamp.toDate());
    return formatted;
  } 
}
getmyDate(Timestamp timestamp) {
    var formatter = new DateFormat('dd/MM/yyyy');
    String formatted = formatter.format(timestamp.toDate());
    return formatted;
  }

  class myclass {
    String subject;
    String description;
    Timestamp deadline; 
    String division;

    myclass({
      this.subject, 
      this.description,
      this.deadline, 
      this.division,
    });
  }