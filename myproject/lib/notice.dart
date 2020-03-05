import 'package:flutter/material.dart';
import 'package:myproject/noticeDescription.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class notice extends StatefulWidget {
  @override
  noticeState createState() {
    return new noticeState();
  }
}
class noticeState extends State<notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height * 0.8,
        maxHeight: MediaQuery.of(context).size.height,
        panel: Container(
          margin: EdgeInsets.only(top: 20.0),
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 11,
              itemBuilder: (BuildContext context, int i) => 
              Container(
                height: 100.0,
                child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: ListTile(
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => noticeDescription(text: '$i',)));},
                  leading: ClipOval(
                    child: Hero(
                      tag: 'Demo Tag' + '$i',
                      child: Image.asset("assets/Aniket.jpg", width: 50.0, height: 50.0,),
                    )      
                  ),
                  title: Text("Aniket Madam", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 18.0),),
                  subtitle: Text("My name is aniket madam my name is sdadsadeaf adeagegegge geageagg geagag ", style: TextStyle(color: Colors.black, fontFamily:"RobotoSlab-Regular.ttf", fontSize: 15.0), overflow: TextOverflow.ellipsis, ),
                  trailing: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text("4/03/2020", style: TextStyle(color: Colors.grey, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 12.0),),
                          )
                        ), 
                        Expanded(
                          child: Container(
                            child: Text("4:30 PM", style: TextStyle(color: Colors.grey, fontFamily:"RobotoSlab-Regular.ttf",fontWeight: FontWeight.bold, fontSize: 12.0),),
                          )
                        ), 

                      ],
                    )
                  ),
                ),
              ),)
          ),),

        body: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          color: Colors.indigoAccent.withOpacity(0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children:<Widget>[
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, left: MediaQuery.of(context).size.width* 0.36),
                alignment: Alignment.topRight,
                child: Text("Notices", style: TextStyle(color:Colors.white, fontSize: MediaQuery.of(context).size.height * 0.04, fontFamily: "RobotoSlab-Regular.ttf", fontWeight: FontWeight.bold),),
              ),
              Container(
                color: Colors.transparent,
                alignment: Alignment.topRight, 
                margin: EdgeInsets.only(right: 10.0, top: 20.0),
                child:InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Image.asset("assets/navigation_image.png",alignment: Alignment.topRight,color: Colors.white,)
                )
              ),
            ]
          ),
        ),
        
        
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
    );
  }
}