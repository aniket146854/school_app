import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/custom_navigation_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'collapsing_navigation_drawer.dart';
import 'package:intl/intl.dart';

class homepage extends StatefulWidget {
  @override
  homepageState createState() {
    return new homepageState();
  }
}
class homepageState extends State<homepage> {
  String name;
  SharedPreferences prefs;
  @override 
  void initState() {
    SharedPreferences.getInstance().then((onValue) {
      setState(() {
        prefs = onValue;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(prefs != null) {
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