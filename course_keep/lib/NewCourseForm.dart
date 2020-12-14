import 'package:course_keep/Models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class newCourseForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<newCourseForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _location;
  String _code;
  String _section;
  int _hours = 0;

  void addContact(Course course) {
    final contactsBox = Hive.box('courses');
    contactsBox.add(course);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //Name field
          Flex(direction: Axis.vertical, children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (value) => _name = value,
            ),
          ]),
          //Location and code field
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
                    height: 45,
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
          //Location field
          Flex(direction: Axis.vertical, children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Location'),
              onSaved: (value) => _location = value,
            ),
          ]),

          RaisedButton(
            child: Text('Add New Contact'),
            onPressed: () {
              _formKey.currentState.save();
              // final newContact = Course(_name, _location, _code,  _section, _hours);
              // addContact(newContact);
              print("saved");
            },
          ),
        ],
      ),
    );
  }

}
