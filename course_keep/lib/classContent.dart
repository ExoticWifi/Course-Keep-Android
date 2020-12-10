import 'package:course_keep/Models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'NewCourseForm.dart';

class classContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            "CourseKeep",
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: <Widget>[
            Expanded(child: _buildListView()),
            newCourseForm(),
          ],
        )
    );
  }

  Widget _buildListView() {
    openBox('courses');
    return ValueListenableBuilder(
      valueListenable: Hive.box('courses').listenable(),
      builder: (context, courseBox, widget) {
        return ListView.builder(itemCount: courseBox.length,
          itemBuilder: (context, index) {
            final course = courseBox.getAt(index) as Course;

            return ListTile(
              title: Text(course.name),
              subtitle: Text(course.location.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      courseBox.putAt(
                        index,
                        Course('${course.name}*', course.location + 1.toString(), course.code),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      courseBox.deleteAt(index);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  openBox(String boxName) async {
      Hive.openBox(boxName);
  }
}