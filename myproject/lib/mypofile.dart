import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/my_info.dart';
import 'package:myproject/opaque_image.dart';
import 'package:myproject/profile_info_big_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:myproject/profile_info_card.dart';

class myprofile extends StatefulWidget {
  @override
  myprofileState createState() {
    return new myprofileState();
  }
}
class myprofileState extends State<myprofile>{

  String standard;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children:<Widget> [
          Column(
            children:<Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  children: <Widget>[
                    OpaqueImage(
                      imageurl: "assets/Aniket.jpg"
                    ),
                    SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "My Profile",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "RobotoSlab-Regular.ttf", fontSize: 20.0),
                            )
                          ),
                          MyInfo(),
                        ],
                      ),)
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 60.0),
                  color: Colors.white,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                         Container(
                            height: 140.0,
                            child:  StreamBuilder(
                              stream: Firestore.instance.collection('Profile').snapshots(),
                                builder: (context, snapshot) {
                                if(!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                    backgroundColor: Colors.redAccent,
                                    value: 0.2,
                                  ));
                                }
                                else {
                                  

                                  for(int i = 0; i < snapshot.data.documents.length; i++) {
                                    if(snapshot.data.documents[i]['mobile1'] == '7887718435' || snapshot.data.documents[i]['mobile2'] == '7887718435') { 
                                      return ProfileInfoBigCard(firstText: "Std: " + snapshot.data.documents[i]['std'] ,secondText: "Blood Group: A+ve",icon: Icon(Icons.person_pin),);
                                    }
                                }
                              }
                              }
                            ),
                         ),
                          
                          Container(
                            height: 140.0,
                            child: ProfileInfoBigCard(firstText: "Age: 10", secondText: "Blood Group: A+ve",icon: Icon(Icons.person_pin),),),
                        ]
                      ),

                      TableRow(
                        children: [
                          Container(
                          height: 140.0,
                          child: ProfileInfoBigCard(firstText: "Std: 5th", secondText: "Div: A", icon: Icon(Icons.school),),),
                          Container(
                            height: 140.0,
                            child: ProfileInfoBigCard(firstText: "Age: 10", secondText: "Blood Group: A+ve",icon: Icon(Icons.person_pin),),),
                        ]
                      ),

                      TableRow(
                        children: [
                          Container(
                          height: 140.0,
                          child: ProfileInfoBigCard(firstText: "Std: 5th", secondText: "Div: A", icon: Icon(Icons.school),),),
                          Container(
                            height: 140.0,
                            child: ProfileInfoBigCard(firstText: "Age: 10", secondText: "Blood Group: A+ve",icon: Icon(Icons.person_pin),),),
                        ]
                      ),
                      
                    ]
                  ),
                )
              )),
            ]
          ),

          Positioned(
            top: screenHeight * (4/9) - 100/2,
            left: 16,
            right:16,
            child: Container(
              height: 80.0,
              child: Row(
                children:<Widget>[
                   Container(
                    
                    child: ProfileInfoCard(firstText: "Good", secondText: "Progress"),),

                   Container(
                   
                    child: ProfileInfoCard(imagePath: "assets/profile.png", firstText: "", secondText: "", hasImage: true,)),

                   Container(
                    child: ProfileInfoCard(firstText: "Good", secondText: "Progress"),),
                ]
              ),
            )
          )
        ]
      )
    );
  }
}