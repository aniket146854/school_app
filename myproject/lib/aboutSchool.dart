import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/gradiantAppBar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class aboutSchool extends StatefulWidget {
  @override
  aboutSchoolState createState() {
    return new aboutSchoolState();
  }
}

class aboutSchoolState extends State<aboutSchool> {
  int _current = 0;
  List imgList = [
    'https://mlsi.in/wp-content/uploads/2017/12/inf-8.jpg',
    'https://mlsi.in/wp-content/uploads/2017/12/inf-2.jpg',
    'https://mlsi.in/wp-content/uploads/2017/12/inf-3.jpg',
    'https://mlsi.in/wp-content/uploads/2017/12/inf-4.jpg',
    'https://mlsi.in/wp-content/uploads/2017/12/inf-5.jpg',
    'https://mlsi.in/wp-content/uploads/2017/12/inf-6.jpg',
    'https://mlsi.in/wp-content/uploads/2017/12/inf-7.jpg',
    'https://mlsi.in/wp-content/uploads/2017/12/inf-1.jpg',
  ];
  String msg_chariman = "“Our youth has the power to make a difference in the society”.";
  String msg_head = "Welcome to Mount Litera School International (MLSI), a leading IB school in Mumbai which offers a holistic curriculum to make your child a future-ready global citizen. Established with the vision to provide outstanding world-class education, we create a nurturing environment for our students where they can explore and develop their emotional, physical, creative and intellectual skills. We recognize and appreciate that each child is unique and will have the freedom and courage to pursue their dreams, while we gently guide them to achieve their maximum potential at school. Our students are happy and confident, respecting themselves, each other and the world around them. The inquiry-based International Baccalaureate curriculum at MLSI focuses on developing conceptual understanding, critical thinking and developing 21st century skills. With a fully integrated approach, as a growing IB continuum school, our children begin their learning journey with the Early Years. They then experience a trans-disciplinary approach through the Primary Years Programme which nurtures and develops young students as caring, active participants in a lifelong journey of learning. We offer the Middle Years Programme, a five year challenging framework that encourages students to make practical connections between their studies and the real world. We are a candidate school for the IB Diploma Programme, which will be a High School Diploma, preparing the students for a world-class university education.";
  String message_chariman = "Mount Litera School International’s holistic approach to academics has earned the trust of our esteemed parents. The international curriculum is further enriched by our cultural ethos. Which makes us as one of the few schools that is truly international, and yet, has deep-rooted Indian values. MLSI is managed by Zee Learn Limited, the education arm of Essel Group. Zee Learn manages over a 100 Mount Litera Zee Schools (MLZS), making it the fastest growing school chain in the country. Kidzee, India’s largest preschool chain, is also managed by Zee Learn.";
  String vision = "Mount Litera School International is a co-educational day school, which provides an outstanding education through the holistic based curriculum. This is achieved in a friendly family atmosphere that nurtures a community feeling where the emotional, physical, creative and intellectual needs of all students are met within an international community.";
  String mission_statement = "The Mount Litera School International will provide students with the happy and secure environment needed for their learning and social development.Our mission is to aspire to the best of teaching and learning , and so ensure that all students achieve the highest academic standards of which they are capable, while being prepared to take their place as world citizens.";
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for(var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
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
                    child: Text("About Our School", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,),),
                  )
                ],
              )
            ),

            
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: CarouselSlider(
                  height: 350.0,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  } ,
                  items: imgList.map((imgUrl){
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          child: Image.network(imgUrl, fit: BoxFit.fill),
                        );
                      }
                    );
                  }).toList(),
                ),),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(
                    imgList,(index, url) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index ? Colors.redAccent : Colors.green,
                        ),
                      );
                    }
                  ),
                ),

                SingleChildScrollView(
                  child:Column(
                    children:<Widget>[
                Container(

                  margin: EdgeInsets.only(top: 15.0, left: 5.0),
                  child: Text("Mission Statement:", style: TextStyle(fontSize: 25.0, color: Colors.red, fontWeight:FontWeight.bold)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 5.0, left: 2.0),
                  child: Text(mission_statement, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.0, left: 5.0),
                  child: Text("Vision:", style: TextStyle(fontSize: 25.0, color: Colors.red, fontWeight:FontWeight.bold)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 5.0, left: 2.0),
                  child: Text(vision, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.0, left: 5.0),
                  child: Text("Message From Chairman:", style: TextStyle(fontSize: 25.0, color: Colors.red, fontWeight:FontWeight.bold)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 5.0, left: 2.0),
                  child: Text(msg_chariman, style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 5.0, left: 2.0),
                  child: Text(message_chariman, style: TextStyle(fontSize: 18.0, color: Colors.black,)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.0, left: 5.0),
                  child: Text("Message From Head:", style: TextStyle(fontSize: 25.0, color: Colors.red, fontWeight:FontWeight.bold)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 5.0, left: 2.0),
                  child: Text(msg_head, style: TextStyle(fontSize: 18.0, color: Colors.black, )),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.0, left: 5.0),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Contact Information:", style: TextStyle(fontSize: 25.0, color: Colors.red, fontWeight:FontWeight.bold)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 5.0, left: 2.0),
                  child: Text("Mount Litera School International,\nGN Block, Behind Asian Heart Hospital,\nNear UTI Building,\nBandra Kurla Complex,\nBandra- East,\nMumbai – 400 051", style: TextStyle(fontSize: 18.0, color: Colors.black, )),
                ),
                
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 5.0),
                      child: Text("School Main Line: Tel.", style: TextStyle(fontSize: 18.0, color: Colors.red, fontWeight:FontWeight.bold)),
                    ),

                    Container(
                      
                      child: Text("022- 62296000", style: TextStyle(fontSize: 18.0, color: Colors.black, )),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 5.0),
                      child: Text("Admissions Tel:", style: TextStyle(fontSize: 18.0, color: Colors.red, fontWeight:FontWeight.bold)),
                    ),

                    Container(
                      child: Text("9930441459 / 9769330319", style: TextStyle(fontSize: 18.0, color: Colors.black, )),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 5.0),
                      child: Text("Admission Email:", style: TextStyle(fontSize: 18.0, color: Colors.red, fontWeight:FontWeight.bold)),
                    ),

                    Container(
                      child: Text("admission@mlsi.in", style: TextStyle(fontSize: 18.0, color: Colors.black, )),
                    ),
                  ],
                ),
              ]
            )
            )
          ],
        ),
      )
          
    );
  }
}