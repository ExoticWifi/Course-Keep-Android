import 'package:course_keep/Models/course.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'classContent.dart';

class HomeScreen extends StatelessWidget {
  var className = "Algebra";
  var classLocation = "Online";
  var classCode = "MA 2312";
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

// body: ListView.separated(
//   itemBuilder: (context, position) {
//     return Card(
//
//     );
//   },
//   separatorBuilder: (context, position) {
//     return SizedBox(
//       height: 15,
//     );
//   },
//   itemCount: className.length,
// ),