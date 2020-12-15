import 'package:course_keep/Models/course.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'classContent.dart';

class HomeScreen extends StatelessWidget {
  var box;

  @override
  Widget build(BuildContext context) {
    openBox('courses');
    return FutureBuilder(
      future: Hive.openBox('courses'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done){
          if (snapshot.hasError)
            return Text(snapshot.error.toString());
          else
            return classContent();
        }
        else
          return Scaffold();
      }

    );
  }
  openBox(String boxName) async {
    Hive.openBox(boxName);
  }
}
