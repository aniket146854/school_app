import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'myOtpScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new loginPage(),
    );
  }
}

class loginPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

String smsCode;
String verificationId;
String role;
String phoneNo;
class _MyHomePageState extends State<loginPage> {
  int flag = 0;
  bool myflag;
  TextEditingController _controller  = TextEditingController();
  
  Future<void> verifyPhone() async {

    phoneNo = '+91'+ phoneNo; 
    print(phoneNo);
    if(FirebaseAuth.instance.currentUser() == null) {
      print("No user");
    }
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      print("Inosde phoneCodeSent");      
      verificationId = verId;
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
      
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential credential) {
      print('verified');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      showAlert(context,'${exception.message}');
   };
      
          await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phoneNo,
              codeAutoRetrievalTimeout: autoRetrieve,
              codeSent: smsCodeSent,
              timeout: const Duration(seconds: 5),
              verificationCompleted: verifiedSuccess,
              verificationFailed: veriFailed);
        }
      
          /*return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return new AlertDialog(
                  title: Text('Enter sms Code'),
                  content: TextField(
                    onChanged: (value) {
                      this.smsCode = value;
                    },
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  actions: <Widget>[
                    new FlatButton(
                      child: Text('Done'),
                      onPressed: () {
                        FirebaseAuth.instance.currentUser().then((user) {
                          if (user != null) {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                          } else {
                            Navigator.of(context).pop();
                            signIn();
                          }
                        });
                      },
                    )
                  ],
                );
              });
        }*/
      
        signIn() async {
          final AuthCredential credential = PhoneAuthProvider.getCredential(
            verificationId: verificationId,
           smsCode: smsCode,
          );
      
          String myphoneNo = phoneNo.substring(3);
          print(myphoneNo);
          var datasnapshot = await Firestore.instance.collection('Users').where('mobile', isEqualTo: myphoneNo).getDocuments();
          role = datasnapshot.documents[0]['Role'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('role', role);
          FirebaseAuth _auth = FirebaseAuth.instance;
          final FirebaseUser user =
          await _auth.signInWithCredential(credential).then((user) {
            ProgressDialog pr = new ProgressDialog(context);
            pr.style(
              message: "Logging in...",
              borderRadius: 10.0,
              backgroundColor: Colors.white,
              progressWidget: CircularProgressIndicator(),
              insetAnimCurve: Curves.easeInOut,
              progress: 0,
              maxProgress: 100.0,
              progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
              messageTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
            );

            pr.show();

            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
            print("Authentication Successful!");
          }).catchError((e) {
             print(e);
            });
        }
      
        @override
        Widget build(BuildContext context) {
          return new Scaffold(
            resizeToAvoidBottomInset: false,
            body: SlidingUpPanel(
              minHeight: MediaQuery.of(context).size.height * 0.62,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              
              panel: Container(
                child: Column(
                  children:<Widget>[

                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.phone),
                              hintText: "Mobile no",
                              hintStyle: TextStyle(color: Colors.black)
                            ),
                            onChanged: (value) {
                              phoneNo = value;
                            }
                        ))
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors:<Color> [
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ]),
                            borderRadius: BorderRadius.all(Radius.circular(80.0))
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 60.0, minHeight:50.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Send OTP',
                                textAlign: TextAlign.center,
                                style: TextStyle(color:Colors.white, fontFamily: "SourceSansPro-Black.ttf"),
                              ),
                            ),
                      ),
                      onPressed: () async{
                        await Firestore.instance.collection('Users').document(phoneNo).get().then((onValue) {
                          if(!onValue.exists){
                          showAlert(context, "Your mobile number is not registered to our school!");
                          _controller.clear();
                        }
                        else {
                          save(phoneNo);
                          verifyPhone();
                        }
                        });
                        
                        

                      })),
                  ]
                ),
              ),
              body: Container(
                child: Image.asset("assets/school.png", alignment: Alignment.topCenter, height: MediaQuery.of(context).size.height,)
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),);

        }
        save(value) async { 
          print(value);
          var datasnapshot;
          int myvalue = 1;
          String name, roll_no, std, mobile1, mobile2, division, myaddress, id;

          
          datasnapshot = await Firestore.instance.collection('Users').where('mobile', isEqualTo: phoneNo).getDocuments();
          role = datasnapshot.documents[0]['Role'];
          print(role);
          var query = await Firestore.instance.collection('Profile').where('mobile1', isEqualTo: value).getDocuments();
          if(query.documents.length == 0) {
            query = await Firestore.instance.collection('Profile').where('mobile2', isEqualTo: value).getDocuments();
          }

          if(role == 'student') {
            name = query.documents[0]['Name'];
            roll_no = query.documents[0]['Roll_no'];
            std = query.documents[0]['std'];
            mobile1 = query.documents[0]['mobile1'];
            mobile2 = query.documents[0]['mobile2'];
            division = query.documents[0]['Division'];
            myaddress = query.documents[0]['Address'];
            
            
            final prefs = await SharedPreferences.getInstance();
            final mobile1_t = 'mobile1';
            final mobile2_t = 'mobile2';
            final address_t = 'address';
            final std_t = 'std';
            final division_t = 'division';
            final rollno_t = 'roll_no';
            final name_t =  'name';
            prefs.setString(mobile1_t, mobile1);
            prefs.setString(mobile2_t, mobile2);
            prefs.setString(address_t, myaddress);
            prefs.setString(std_t, std);
            prefs.setString(division_t, division);
            prefs.setString(rollno_t, roll_no);
            prefs.setString(name_t, name);
          }
          else if(role == 'teacher') {
            print("Entered into teacher");
            name = query.documents[0]['Name'];
            id = query.documents[0]['id'].toString();
            print(name);
            print(id);
            std = query.documents[0]['std'];
            mobile1 = query.documents[0]['mobile1'];
            mobile2 = query.documents[0]['mobile2'];
            division = query.documents[0]['Division'];
            myaddress = query.documents[0]['Address'];
            print(name + id + std + mobile1 + mobile2 + division + myaddress);
            final prefs = await SharedPreferences.getInstance();
            final mobile1_t = 'mobile1';
            final mobile2_t = 'mobile2';
            final address_t = 'address';
            final std_t = 'std';
            final division_t = 'division';
            final id_t = 'id';
            final name_t =  'name';
            prefs.setString(mobile1_t, mobile1);
            prefs.setString(mobile2_t, mobile2);
            prefs.setString(address_t, myaddress);
            prefs.setString(std_t, std);
            prefs.setString(division_t, division);
            prefs.setString(id_t, id);
            prefs.setString(name_t, name);
          }
        }
        void showAlert(BuildContext context, String errormsg) {
          Alert(
            context: context, 
            title: "Authentication Error",
            desc: errormsg,
            buttons: [
              DialogButton(
                width: 120.0,
                child: Text("Ok",style: TextStyle(color:Colors.white),),
                onPressed: ()=>  {
                  _controller.clear(),
                  Navigator.pop(context)
                 }
                ),
            ]
          ).show();
        }

}


  