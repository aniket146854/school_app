import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/login_page.dart';
import 'package:myproject/schoolEvent.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'aboutSchool.dart';
import 'custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'main.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 210;
  double minWidth = 70;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;
  SharedPreferences prefs;
  String mobile1, mobile2;
  @override
  void initState() {
    SharedPreferences.getInstance().then((onValue) {
      mobile1 = onValue.getString('mobile1');
      mobile2 = onValue.getString('mobile2');
    });
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    return Material(
      elevation: 80.0,
      child: Container(
        width: widthAnimation.value,
        color: drawerBackgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 5.0),
              child:ClipOval (
                 child: Image.asset("assets/Aniket.jpg", fit: BoxFit.cover, height: 75, width: 75, alignment: Alignment.topLeft,),),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0, left: 10.0),
              child: StreamBuilder(
                stream: Firestore.instance.collection('Profile').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    String name = "";
                    for(int i = 0; i < snapshot.data.documents.length; i++) {
                      if(snapshot.data.documents[i]['mobile1'] == mobile1 && snapshot.data.documents[i]['mobile2'] == mobile2) {
                        name = snapshot.data.documents[i]['Name'];
                        break;
                      }
                    
                    }
                    return Container(
                      child: Text(name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0)),
                    );
                  }
                  else {
                    return Container();
                  }
                }
              )
            
              
              
            ),
            Divider(color: Colors.grey, height: 40.0,),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(height: 12.0);
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                      onTap: () {
                        setState(() {
                          if(counter == 0) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                          }
                          else if(counter == 1) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => aboutSchool()));
                          }
                          else if(counter == 2) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => schoolEvent()));
                          }
                          if(counter == 3) {
                            signoutAccount();      
                          }
                          currentSelectedIndex = counter;
                        });
                      },
                      isSelected: currentSelectedIndex == counter,
                      title: navigationItems[counter].title,
                      icon: navigationItems[counter].icon,
                      animationController: _animationController,
                  );
                },
                itemCount: navigationItems.length,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                  isCollapsed
                      ? _animationController.forward()
                      : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: _animationController,
                color: selectedColor,
                size: 50.0,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
  signoutAccount() async{
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
  }
}