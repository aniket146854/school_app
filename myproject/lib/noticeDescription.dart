import 'package:flutter/material.dart';
import 'package:myproject/narrow_app_bar.dart';
import 'package:draggable_floating_button/draggable_floating_button.dart';

class noticeDescription extends StatelessWidget {
  String index, subject, sender, description, sendto;
  noticeDescription({Key key, @required this.index, @required this.sendto, @required this.description, @required this.sender, @required this.subject}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: NarrowAppBar(
       leading: InkWell(
         onTap: ()=> Navigator.of(context).pop(),
        child:Container(
          child: Icon(Icons.arrow_back, color: Colors.white, size: 40.0,)),
       ),
       trailing:Text(""),
      ),
      
      body: Container(
        
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),

              Positioned(
                top: 75.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height - 100,
                  width: MediaQuery.of(context).size.width,
                )
              ), 

              Positioned(
                top: 30.0,
                left: (MediaQuery.of(context).size.width / 2) - 75.0,
                child: Hero( 
                  tag: "Demo Tag" + index,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/Aniket.jpg"),
                        fit: BoxFit.cover)
                    ),
                    height: 150.0,
                    width: 150.0,
                  ),
              ),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 250.0),
              
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                  children:<Widget>[
                    Row(
                      children:<Widget>[
                        
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 5.0),
                          child: Text("Sender: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize :20.0)),
                        ),
                        
                        Expanded(
                         child:Container(
                              margin: EdgeInsets.only(left: 5.0, top: 10.0),
                              child: Text(sender, style: TextStyle(fontSize :17.0)),
                          ),
                        ),
                      ]
                    ),

                    Row(

                      children:<Widget>[
                        
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 5.0),
                          child: Text("To : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize :20.0)),
                        ),
                        
                        Expanded(
                         child:Container(
                              margin: EdgeInsets.only(left: 5.0, top: 10.0),
                              child: Text(getwhomsent(sendto), style: TextStyle(fontSize :17.0)),
                          ),
                        ),
                      ]
                    ),

                    Row(

                      children:<Widget>[    
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 5.0),
                          child: Text("Subject: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize :20.0)),
                        ),
                        
                        Expanded(
                         child:Container(
                              margin: EdgeInsets.only(left: 5.0, top: 10.0),
                              child: Text(subject, style: TextStyle(fontSize :17.0)),
                          ),
                        ),
                      ]
                    ),

                   Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text("Description: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize :20.0)),
                    ),

                  Expanded(
                  child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.only(left: 5.0, top: 10.0, right: 3.0),
                      child: Text(description, style: TextStyle(fontSize :17.0)),
                  ),
                  )
                  ),
                  ],
                )),
              ),
            ],
        )
      ),
      
    );
  }
  getwhomsent(String text) {
    if(text == 'all') {
      return "to all";
    }
    else {
      return "standard "+ text; 
    }
  }
}