import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:shared_preferences/shared_preferences.dart';

List selectedValues;
class addNotice extends StatefulWidget {
  @override
  addNoticeState createState() {
    return new addNoticeState();
  }
}
List<String> mylist = List<String>();
class addNoticeState extends State<addNotice> {
  String _value;
  List<String> div_selected;
  Map<String, bool> mymap = new Map<String, bool>();
  List<myclass> _selectedValues = [];
  bool isSwitched = false;
  SharedPreferences prefs;
  String name, id;
  TextEditingController controller_description = new TextEditingController();
  TextEditingController controller_subject = new TextEditingController();

  @override
  void initState() {
    getAllRecipient();
    SharedPreferences.getInstance().then((onValue){
      setState(() {
        name = onValue.get('name');
        id = onValue.get('id');
      });
    }
    );

        // TODO: implement initState
    super.initState();
  }
    @override
  void dispose() {
    mylist.clear();
    // TODO: implement dispose
    super.dispose();
  }
      @override
      Widget build(BuildContext context) {
        if(name != null) {
        return Scaffold( 
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
              child: Column(
              children:<Widget>[
                Container(
                  
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    boxShadow:[
                      BoxShadow(
                        color: Colors.purpleAccent.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ]
                  ),
                  height: 75.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: InkWell(
                        child: Icon(Icons.arrow_back,size: 33.0,color: Colors.white),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                       child: Text("Add Notice", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30.0),),
                      ),
                       Container(
                         margin: EdgeInsets.only(right: 10.0, top: 5.0),
                       child: InkWell(
                        child: Icon(Icons.add, size: 33.0, color: Colors.white),
                        onTap: () async{
                          if(isSwitched == true) {
                            var datasnapshot = await Firestore.instance.collection('NotiveToApprove');
                            Timestamp ts = Timestamp.fromDate(DateTime.now());
                            String desc, sub;
                            desc = controller_description.text;
                            sub = controller_subject.text;
                            List<String> l = [];
                            for(int i = 0; i < _selectedValues.length ;i++) {
                              l.add(_selectedValues.elementAt(i).class_name);
                            }
                            datasnapshot.document().setData({'date': ts, 'description': desc, 'subject':sub, 'name': name, 'id': id, 'sendto':l});
                          }
                          else {
                            var datasnapshot = await Firestore.instance.collection('Notice');
                            Timestamp ts = Timestamp.fromDate(DateTime.now());
                            String desc, sub;
                            desc = controller_description.text;
                            sub = controller_subject.text;
                            List<String> l = [];
                            for(int i = 0; i < _selectedValues.length ;i++) {
                              l.add(_selectedValues.elementAt(i).class_name);
                            }
                             
                            datasnapshot.document().setData({'date': ts, 'description': desc, 'subject':sub, 'name': name, 'id': id, 'sendto':l});
                            Navigator.of(context).pop();
                          }
                        },
                      ),)
                       
                    ]
                  ),
                ),
                Container(
                  height: 80.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text("From", style: TextStyle(fontSize: 20.0, color: Colors.grey,)),
                      ),
                      Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0, top: 3.0),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: name,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        )
                      )),
                    ]
                  )
                ),
    
                
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Text("To  ", style: TextStyle(fontSize: 20.0, color: Colors.grey,)),
                ),
    
                FlutterTagging<myclass>(
                  initialItems: _selectedValues,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.purple.withAlpha(30),
                      hintText: 'Select Recipient',
                      labelText: 'Select Recipient',
                  ),
                ),
                findSuggestions: myclassService.getmyclass,
                additionCallback: (value) {
                  return myclass(
                    class_name: value,
                    position: 0,
                  );
                },
    
                onAdded: (MyClass) {
                  return myclass();
                },
    
                configureSuggestion: (Myclass) {
                  return SuggestionConfiguration(
                    title: Text(Myclass.class_name),
                    additionWidget: Chip(
                      avatar: Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                      label: Text('Add new Recipient'),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                      backgroundColor: Colors.purpleAccent,
                    ),
                  );
                },
    
                configureChip: (Myclass) {
                  return ChipConfiguration(
                    label: Text(Myclass.class_name),
                    backgroundColor: Colors.purpleAccent,
                    labelStyle: TextStyle(color: Colors.white,),
                    deleteIconColor: Colors.white,
                  );
                },
                  
                onChanged: () {
                  setState(() {
                    
                  });
                },
                ),
    
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                      child: Container(
                        child: Text("Want to send to principal for Confirmation?", style: TextStyle(fontSize: 20.0, color: Colors.grey),),
                      ),),

                      Container(
                        child: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              
                            });
                          },
                          activeTrackColor: Colors.purpleAccent.withAlpha(30),
                          activeColor: Colors.purpleAccent,
                        )
                      )
                    ],
                  )
                ),

                  Container(
                  height: 80.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text("Subject", style: TextStyle(fontSize: 20.0, color: Colors.grey,)),
                      ),
                      Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0, top: 3.0),
                        child: TextFormField(
                          controller: controller_subject,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Enter your subject",
                          ),
                        )
                      )),
                    ]
                  )
                ),
                
                SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: controller_description,
                      maxLines: null,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Write Description",
                      ),
                    )
                  ),   )          
              ]
            )
          ),
        );
      }
      else {
        return Container(
          child: CircularProgressIndicator(
            backgroundColor: Colors.purpleAccent,
            strokeWidth: 5.0,
          )
        );
      }
    }
      void showAllChoice(BuildContext context) async{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Expanded(
              child: ListView(
                children: mymap.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    value: mymap[key], 
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        mymap[key] = value;
                      });
                    },
                  );
                }    
                ).toList(),
              )
            );
          }
        );
      }
    
      void getAllRecipient() async{
        var datasnapshot = await Firestore.instance.collection('class').getDocuments();
        mylist.add('all');
        if(datasnapshot.documents.length > 0) {
          for(int i = 0; i < datasnapshot.documents.length; i++) {
            mylist.add(datasnapshot.documents[i]['Division']);
            for(int j = 1; j <= datasnapshot.documents[i]['count']; j++) {
              mylist.add(datasnapshot.documents[i]['Division'] + datasnapshot.documents[i]['Division' + j.toString()]);
            }
          }
        }
        var mysnapshot = await Firestore.instance.collection('Profile').getDocuments();
        for(int i = 0; i < mysnapshot.documents.length; i++) {
          mylist.add(mysnapshot.documents[i]['Name']);
        }
        mylist.add('Principal');
        print(mylist);

      }
}
sendNotice() {
  print(selectedValues);
}

class myclassService {
  static Future<List<myclass>> getmyclass(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    List<myclass> my_list = [];
    for(int i = 0; i < mylist.length; i++) {
      my_list.add(myclass(class_name: mylist.elementAt(i), position: (i + 1)));
    }
    return my_list.where((lang) => lang.class_name.toLowerCase().contains(query.toLowerCase())).toList();
  } 
}

class myclass extends Taggable {
  final String class_name;
  final int position;

  myclass({
    this.class_name,
    this.position,
  });
  List<Object> get props => [class_name];

  String toJson() => '''  {
    "class_name": $class_name,\n
    "position": $position\n
  }''';
}