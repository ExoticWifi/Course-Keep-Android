import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'Models/course.dart';
import 'NewCourseForm.dart';

final _formKey = GlobalKey<FormState>();
String _name;
String _location;
String _code;
String _section;
String _startTime = "8:00 AM";
String _endTime = "8:00 AM";
int _hours = 0;
bool _sunday;
bool _monday;
bool _tuesday;
bool _wednesday;
bool _thursday;
bool _friday;
bool _saturday;
bool _visible = false;
int x;
TimeOfDay startTime = new TimeOfDay(hour:8, minute: 0);
TimeOfDay endTime = new TimeOfDay(hour:8, minute: 0);
final values = List.filled(7, false);

class AddClassScreen extends StatelessWidget {
  void addContact(Course course) {
    final contactsBox = Hive.box('courses');
    contactsBox.add(course);
  }

  @override
  Widget build(BuildContext context) {
    newCourseForm form;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                textAlign: TextAlign.left,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              "add",
              textAlign: TextAlign.left,
            ),
            onPressed: () {
              _formKey.currentState.save();
              print(_startTime);
              print(_endTime);
              final newContact = Course(_name, _location, _code,  _hours, _section, _sunday, _monday, _tuesday, _wednesday, _thursday, _friday, _saturday, _startTime, _endTime);
              addContact(newContact);
              print("saved");
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                " Add Course",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 2,
            ),
            form = newCourseForm(),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}

class newCourseForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<newCourseForm> {

  Future<Null> _showTimePicker(BuildContext context, TimeOfDay time, String type) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (picked != null && picked != time) {
      setState(() {
        if (type == "start"){
          startTime = picked;
          _startTime = startTime.format(context);
        }
        else {
          endTime = picked;
          _endTime = endTime.format(context);
        }
        time = picked;
      });
    }
  }
  void addContact(Course course) {
    final contactsBox = Hive.box('courses');
    contactsBox.add(course);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Card(
              child: Column(
                  mainAxisSize: MainAxisSize.min, children: <Widget>[
                //Name field
                Flex(direction: Axis.vertical, children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onSaved: (value) => _name = value,
                  ),
                ]),
                //Location and code field-
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Code'),
                            onSaved: (value) => _code = value,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Section'),
                            onSaved: (value) => _section = value,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                //Hours field
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Credit Hours: $_hours",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                          child: Card(
                            color: Colors.grey[300],
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.horizontal_rule_rounded),
                                  onPressed: () {
                                    if (_hours > 0) {
                                      setState(() {
                                        _hours -= 1;
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_rounded),
                                  onPressed: () {
                                    setState(() {
                                      _hours += 1;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: 5,
                  child: Divider(
                    color: Colors.grey[500],
                    thickness: 1,
                  ),
                ),
                //Location field
                Flex(direction: Axis.vertical, children: [
                  TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Location'),
                    onSaved: (value) => _location = value,
                  ),
                ]),
              ])),
          SizedBox(
            height: 50,
          ),
          Card(
              child: Column(
                children: [
                  weekdayState(),
                  Visibility(
                      visible: _visible,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1,
                            child: Divider(
                              color: Colors.grey[500],
                              thickness: 1,
                            ),
                          ),
                          //Start time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Start Time:",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              RaisedButton(
                                child: Text(startTime.format(context)),
                                onPressed: (){
                                  _showTimePicker(context, startTime, "start");
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1,
                            child: Divider(
                              color: Colors.grey[500],
                              thickness: 1,
                            ),
                          ),
                          //End time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "End Time:",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              RaisedButton(
                                child: Text(endTime.format(context)),
                                onPressed: (){
                                  _showTimePicker(context, endTime, "end");
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                        ],
                      )
                  )
                ],
              )
          ),
        ],
      ),
    );
  }


  Widget weekdayState() {
    return WeekdaySelector(
      firstDayOfWeek: 7,
      values: values,
      onChanged: (i) {
        setState(() {
          values[i % 7] = !values[i % 7];
          for (x = 0; x < values.length; x++){
            if (values[x] == true){
              _visible = true;
              break;
            }
            else{
              if(x == values.length - 1){
                _visible = false;
              }
            }
          }
          setDays();
          print(_sunday);
        });
      },
      fillColor: Colors.grey[300],
      selectedFillColor: Colors.orange,
      selectedColor: Colors.black,
    );
  }

  Widget setDays(){
    _sunday = values[0];
    _monday = values[1];
    _tuesday = values[2];
    _wednesday = values[3];
    _thursday = values[4];
    _friday = values[5];
    _saturday = values[6];
  }

}