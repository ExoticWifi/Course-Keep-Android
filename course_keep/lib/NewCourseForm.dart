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

  void addContact(Course course) {
    final contactsBox = Hive.box('courses');
    contactsBox.add(course);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  onSaved: (value) => _location = value,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Code'),
                  onSaved: (value) => _code = value,
                ),
              ),
            ],
          ),
          RaisedButton(
            child: Text('Add New Contact'),
            onPressed: () {
              _formKey.currentState.save();
              final newContact = Course(_name, _location, _code);
              addContact(newContact);
              print("saved");
            },
          ),
        ],
      ),
    );
  }

}
