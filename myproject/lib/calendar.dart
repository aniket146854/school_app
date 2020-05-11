import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myproject/homepage.dart';
import 'package:myproject/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


// Example holidays
void main() {
  initializeDateFormatting().then((_) => runApp(myCalendar()));
}

class myCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyCalendarPage(title: 'Calendar'),
    );
  }
}

class MyCalendarPage extends StatefulWidget {
  MyCalendarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyCalendarPage> with TickerProviderStateMixin {
  bool dialVisible = true;
  static bool flag = true;
  Map<DateTime, List> _events = Map<DateTime, List>();
  Map<DateTime, List> _holidays = Map<DateTime, List>();
  List _selectedEvents = List();
  AnimationController _animationController;
  CalendarController _calendarController;
  final _selectedDay = DateTime.now();
  @override
  void initState() {

          _calendarController = CalendarController();
      
          _animationController = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 400),
          );
      
          _animationController.forward();
          super.initState();
    }
      
        @override
        void dispose() {
          _animationController.dispose();
          _calendarController.dispose();
          super.dispose();
        }
      
        void _onDaySelected(DateTime day, List events) {
          print('CALLBACK: _onDaySelected');
          setState(() {
            _selectedEvents = events; 
          });
        }
      
        void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
          print('CALLBACK: _onVisibleDaysChanged');
        }
      
      Widget _buildHolidaysMarker() {
          return Icon(
            Icons.add_box,
            size: 20.0,
            color: Colors.blueGrey[800],
          );
        }
  
      Widget _buildEventsMarker(DateTime date, List events) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: _calendarController.isSelected(date)
                  ? Colors.brown[500]
                  : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
            ),
            width: 16.0,
            height: 16.0,
            child: Center(
              child: Text(
                '${events.length}',
                style: TextStyle().copyWith(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }
  
      Widget _buildTableCalendarWithBuilders() {
          return TableCalendar(
            locale: 'pl_PL',
            calendarController: _calendarController,
            events: _events,
            holidays: _holidays,
            initialCalendarFormat: CalendarFormat.month,
            formatAnimation: FormatAnimation.slide,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            availableGestures: AvailableGestures.all,
            availableCalendarFormats: const {
              CalendarFormat.month: '',
              CalendarFormat.week: '',
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
              holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
            ),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
            ),
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, _) {
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    color: Colors.deepOrange[300],
                    width: 100,
                    height: 100,
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(fontSize: 16.0),
                    ),
                  ),
                );
              },
              todayDayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  color: Colors.amber[400],
                  width: 100,
                  height: 100,
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(fontSize: 16.0),
                  ),
                );
              },
              markersBuilder: (context, date, events, holidays) {
                final children = <Widget>[];
      
          
                if (events.isNotEmpty) {
                  children.add(
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: _buildEventsMarker(date, events),
                    ),
                  );
                }
      
               if (holidays.isNotEmpty) {
                  children.add(
                    Positioned(
                      right: -2,
                      top: -2,
                      child: _buildHolidaysMarker(),
                    ),
                  );
                }
      
                return children;
              },
            ),
            
            onDaySelected: (date, events) {
              _onDaySelected(date, events);
              _animationController.forward(from: 0.0);
            },
            onVisibleDaysChanged: _onVisibleDaysChanged,
          );
        }
      SpeedDial buildSpeedDial() {
          return SpeedDial(
            marginBottom: 20.0,
            backgroundColor: Colors.indigoAccent,
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            onOpen: () => print("OPENING DIAL"),
            onClose: () => print("Closing DIAL"),
            visible: dialVisible,
            curve: Curves.bounceIn,
            children: [
              SpeedDialChild(
                child: Icon(Icons.accessibility, color: Colors.white),
                backgroundColor: Colors.deepOrange.withOpacity(0.9),
                onTap: (){
                  setState(() {
                        _calendarController.setCalendarFormat(CalendarFormat.month);
                      });
                },
                label: 'Show Month',
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                labelBackgroundColor: Colors.deepOrangeAccent.withOpacity(0.9),
              ),
              SpeedDialChild(
                child: Icon(Icons.brush, color: Colors.white),
                backgroundColor: Colors.deepOrange.withOpacity(0.9),
                onTap: () {
                  setState(() {
                        _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                      });
                },
                label: 'Show 2 Weeks',
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                labelBackgroundColor: Colors.deepOrangeAccent.withOpacity(0.9),
              ),
              SpeedDialChild(
                child: Icon(Icons.keyboard_voice, color: Colors.white),
                backgroundColor: Colors.deepOrange.withOpacity(0.9),
                onTap: (){
                  setState(() {
                        _calendarController.setCalendarFormat(CalendarFormat.week);
                      });
                },
                label: 'Show 1 week',
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                labelBackgroundColor: Colors.deepOrangeAccent,
              )
            ],
          );
        }
  
        Widget _buildTableCalendar() {
          return TableCalendar(
            calendarController: _calendarController,
            events: _events,
            holidays: _holidays,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              selectedColor: Colors.deepOrange[400],
              todayColor: Colors.deepOrange[200],
              markersColor: Colors.brown[700],
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
              formatButtonDecoration: BoxDecoration(
                color: Colors.deepOrange[400],
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onDaySelected: _onDaySelected,
            onVisibleDaysChanged: _onVisibleDaysChanged,
          );
        }
  
        Widget _buildButtons() {
          final dateTime = _events.keys.elementAt(_events.length - 2);
      
          return Column(
            children: <Widget>[
              
            ],
          );
        }
  
        Widget _buildEventList() {
          if(_selectedEvents.length != 0) {
            return ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (BuildContext context, int i) => 
                Container(
                  child: Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: ListTile(
                      title: Text(_selectedEvents[i]),
                    ),
                  ),
                )
            );
          }
          else {
            return Container(

              child: Text("No Events!", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            );
          }
        }
  
        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigoAccent,
              title: Text(widget.title),
            ),
            body: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
                ),
                child: StreamBuilder(
                stream: Firestore.instance.collection('events').snapshots(),
                builder: (context, snapshot) {    
                  if(snapshot.hasData) {
                    List<String> myevents;
                    List<String> myholiday;
                    for(int i = 0; i < snapshot.data.documents.length; i++) {
                      myevents = List<String>();
                      myholiday = List<String>();
                      for(int j = 1;  j <= snapshot.data.documents[i]['no_event']; j++) {
                        myevents.add(snapshot.data.documents[i]['event' + j.toString()]); 
                      }
  

                      for(int k = 1; k <= snapshot.data.documents[i]['no_holiday']; k++) {
                        myholiday.add(snapshot.data.documents[i]['holiday' + k.toString()]);
                        myevents.add(snapshot.data.documents[i]['holiday' + k.toString()]);
                      }

                      DateTime dt = snapshot.data.documents[i]['date'].toDate();
                      if(myevents.isNotEmpty == true) 
                        _events[dt] = myevents;
                      if(myholiday.isNotEmpty == true)
                        _holidays[dt] = myholiday;
                    
                    }
                    if(flag == true) {
                      _selectedEvents = _events[_selectedDay] ?? [];
                      flag = false;
                    }
                    return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      // Switch out 2 lines below to play with TableCalendar's settings
                      //-----------------------
                      _buildTableCalendar(),
                      // _buildTableCalendarWithBuilders(),
                      const SizedBox(height: 8.0),
                      _buildButtons(),
                      const SizedBox(height: 8.0),
                      Expanded(child: _buildEventList()),
                    ],
                  ); 
                }
                else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.redAccent,
                    )
                  );
                }
              }
            ),),
            floatingActionButton: buildSpeedDial(),
          );
      
        // Simple TableCalendar configuration (using Styles)
      
        // More advanced TableCalendar configuration (using Builders & Styles)
      
        
      
  
      }
      
}