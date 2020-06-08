import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';

import 'ListEvents.dart';

class schoolEvent extends StatefulWidget {
  @override
  schoolEventState createState() {
    return new schoolEventState();
  }
}

class schoolEventState extends State<schoolEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SingleChildScrollView(
          child:Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: InkWell(
                      child: Icon(Icons.arrow_back_ios, size: 30.0),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(left:20.0),
                    child: Text("Events", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,),),
                  )
                ],
              ),
            ),

            Container(
            child: StreamBuilder(
             stream: Firestore.instance.collection('event_photos').snapshots(),
             builder:(context, snapshot) {
               if(snapshot.hasData) {
                int count = snapshot.data.documents.length;
                return Container(
                  padding: EdgeInsets.only(top: 10.0),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: count,
                  itemBuilder: (BuildContext context, int i) =>
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListEvents(year: snapshot.data.documents[i]['year'], mydocumentID: snapshot.data.documents[i]['documentID'])));
                    },
                    child: Padding(
                    padding: EdgeInsets.all(10.0), 
                    child: Container(
                        height: 200.0,
                    constraints: new BoxConstraints.expand(
                      height: 200,
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3.0
                      ),
                      image: new DecorationImage(
                        image: new NetworkImage(snapshot.data.documents[i]['demo_img']),
                        fit: BoxFit.cover
                      )
                    ),
                    child: new Text(snapshot.data.documents[i]['year'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  )
                ))));
               }
               else {
                 return CircularProgressIndicator(
                   backgroundColor: Colors.red,
                   strokeWidth: 6.0,
                 );
               }

             }
           )
          )
          ]
        )
      )
    );
    
  }
}