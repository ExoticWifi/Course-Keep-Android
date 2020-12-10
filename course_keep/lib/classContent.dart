import 'package:course_keep/AddClassScreen.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "CourseKeep",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: _buildListView()),
            newCourseForm(),
          ],
        ));
  }

  Widget _buildListView() {
    openBox('courses');
    return ValueListenableBuilder(
      valueListenable: Hive.box('courses').listenable(),
      builder: (context, courseBox, widget) {
        return ListView.builder(
          itemCount: courseBox.length + 1,
          itemBuilder: (context, index) {
            print(index);
            if (index == courseBox.length){
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddClassScreen()));
                      }
                  ),
                ],
              );
            }
            else {
              final course = courseBox.getAt(index) as Course;
              return Card(
                child: InkWell(
                  onTap: () {
                    print("Tapped!");
                  },
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(course.name),
                          subtitle: Text(course.location),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 45,
                              child: (IconButton(
                                icon: Icon(Icons.delete),
                                iconSize: 35,
                                onPressed: () {
                                  courseBox.deleteAt(index);
                                },
                              )),
                            ),
                            Text(course.code),
                            SizedBox(
                              width: 10,
                            ),
                            // Container(
                            //   width: 40,
                            //   height: 45,
                            //   child: (IconButton(
                            //     icon: Icon(Icons.refresh),
                            //     iconSize: 35,
                            //     onPressed: () {
                            //       courseBox.putAt(
                            //         index,
                            //         Course('${course.name}*',
                            //             course.location + 1.toString(),
                            //             course.code),
                            //       );
                            //     },
                            //   )),
                            // ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            };
          },
        );
      },
    );
  }

  openBox(String boxName) async {
    Hive.openBox(boxName);
  }
}