import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'main.dart';

class OtpScreen extends StatefulWidget {
    @override 
    _OtpScreenState createState() => _OtpScreenState();
}

buildSecurityText() {
  return Text("Enter OTP",
    style: TextStyle(color: Colors.white, fontSize: 21.0, fontWeight: FontWeight.bold),
  );
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> currentPin = ["","","","","",""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    borderSide: BorderSide(color: Colors.transparent),
  );
  int pinIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue[100],Colors.blue],
        ),
      ),
      child: SafeArea(
      child: Column(
        children:<Widget>[
          buildExitButton(),
          Expanded(
            child: Container(
              alignment: Alignment(0,0.5),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  buildSecurityText(),
                  SizedBox(height: 40.0,),
                  buildPinRow(),
                  Container(
                    margin: EdgeInsets.only(top: 70.0),
                  child: ProgressButton(
                    borderRadius: 10.0,
                    color: Colors.blue,
                    defaultWidget: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                    progressWidget: const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50.0,
                    onPressed: () async{
                      int score = await Future.delayed(
                        const Duration(milliseconds: 4000), () => 42);
                    
                        FirebaseAuth.instance.currentUser().then((user) {
                          if (user != null) {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                          } else {
                            smsCode = pinOneController.text + pinTwoController.text + pinThreeController.text + pinFourController.text + pinFiveController.text + pinSixController.text;
                            signIn();
                          }
                        });

                    },  
                  ))
                ],
              ),
            )
          ),

          buildNumberPad(),
        ]
      )
    )));
  }

  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 1,
                    onPressed: () {
                      pinIndexSetup("1");
                    }
                  ),
                  KeyboardNumber(
                    n: 2,
                    onPressed: () {
                      pinIndexSetup("2");
                    }
                  ),
                  KeyboardNumber(
                    n: 3,
                    onPressed: () {
                      pinIndexSetup("3");
                    }
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 4,
                    onPressed: () {
                      pinIndexSetup("4");
                    }
                  ),
                  KeyboardNumber(
                    n: 5,
                    onPressed: () {
                      pinIndexSetup("5");
                    }
                  ),
                  KeyboardNumber(
                    n: 6,
                    onPressed: () {
                      pinIndexSetup("6");
                    }
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 7,
                    onPressed: () {
                      pinIndexSetup("7");
                    }
                  ),
                  KeyboardNumber(
                    n: 8,
                    onPressed: () {
                      pinIndexSetup("8");
                    }
                  ),
                  KeyboardNumber(
                    n: 9,
                    onPressed: () {
                      pinIndexSetup("9");
                    }
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      
                      onPressed: null,
                    )
                  ),
                  KeyboardNumber(
                    n: 0,
                    onPressed: () {
                      pinIndexSetup("9");
                    }
                  ),
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      height: 60.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      onPressed: () {
                        clearPin();
                      },
                      child: Image.asset("assets/backspace.png", color: Colors.white),
                    )
                  ),
                ],
              ),
            ]
          )
        )
      )
    );
  }

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
            Fluttertoast.showToast(
              msg: "You have entered incorrect OTP, Login again",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
            });
        }
  
  clearPin() {
    if(pinIndex == 0) {
      pinIndex = 0;
    }
    else if(pinIndex == 6) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
    else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    if(pinIndex == 0) {
      pinIndex = 1;
    }
    else if(pinIndex < 6) {
      pinIndex++;
    }
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";
    currentPin.forEach((e) {
      strPin += e;
    });
    if(pinIndex == 6)
      print(strPin);
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
      case 5:
        pinFiveController.text = text;
        break;
      case 6:
        pinSixController.text = text;
        break;

      default:
    }
  }
  buildPinRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      PinNumber(
        textEditingController: pinOneController,
        outlineInputBorder: outlineInputBorder,
      ),
      PinNumber(
        textEditingController: pinTwoController,
        outlineInputBorder: outlineInputBorder,
      ),
      PinNumber(
        textEditingController: pinThreeController,
        outlineInputBorder: outlineInputBorder,
      ),
      PinNumber(
        textEditingController: pinFourController,
        outlineInputBorder: outlineInputBorder,
      ),
      PinNumber(
        textEditingController: pinFiveController,
        outlineInputBorder: outlineInputBorder,
      ),
      PinNumber(
        textEditingController: pinSixController,
        outlineInputBorder: outlineInputBorder,
      ),

    ],
  );
}

  buildExitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {

            },
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(Icons.clear, color: Colors.white),
          )
        )
      ],
    );
  }

}

class PinNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  PinNumber({this.textEditingController, this.outlineInputBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.white30,
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21.0,
          color: Colors.white,

        ),
      )
    );
  }
  
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;

  KeyboardNumber({this.n, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.withOpacity(0.1),

      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        height: 90.0,
        child: Text(
          "$n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24 * MediaQuery.of(context).textScaleFactor,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      )
    );
  }
  
}