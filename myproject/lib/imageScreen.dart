import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_player/video_player.dart';

class imageScreen extends StatelessWidget {
  String about, year, mydocumentID;
  imageScreen({@required this.about, @required this.year, @required this.mydocumentID});

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
                    child: Text(about, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,),),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 10.0,top: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Text("Photos", style: TextStyle(color: Colors.indigo, fontSize: 25.0, fontWeight: FontWeight.bold),),
            ),

            Container(
            child: StreamBuilder(
             stream: Firestore.instance.collection('event_photos/' + mydocumentID + "/1").where('about', isEqualTo: about).snapshots(),
             builder:(context, snapshot) {
               if(snapshot.hasData) {
                int count = snapshot.data.documents[0]['img_count'];
                return Container(
                  padding: EdgeInsets.only(top: 10.0),
                  height: MediaQuery.of(context).size.height,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: count,
                    itemBuilder: (BuildContext context, int i) =>
                    Container(
                      width: 200.0,
                      constraints: new BoxConstraints.expand(
                        height: 200,
                      ),
                      decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new NetworkImage(snapshot.data.documents[0]['img' + (i + 1).toString()]),
                        fit: BoxFit.cover
                       )
                      ),
                    ), 
                    staggeredTileBuilder: (int index) => 
                      new StaggeredTile.count(2, index.isEven ? 2 : 1),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  )
                );
               }
               else {
                 return Container(
                   width: MediaQuery.of(context).size.width,
                   height: MediaQuery.of(context).size.height,
                 child: Center(
                   child: CircularProgressIndicator(
                   backgroundColor: Colors.red,
                   strokeWidth: 6.0,
                 ))
                 );
               }

             }
           )
          ),

         

          ]
        )
      )
    );
  }
} 

