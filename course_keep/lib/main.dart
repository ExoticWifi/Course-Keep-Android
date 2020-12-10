
import 'package:course_keep/Models/course.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'AddClassScreen.dart';
import 'HomeScreen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(CourseAdapter());
  Hive.openBox('courses');
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/second': (context) => AddClassScreen(),
    },
  ),
  );
}


