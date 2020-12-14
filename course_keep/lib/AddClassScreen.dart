import 'package:flutter/material.dart';

import 'NewCourseForm.dart';

class AddClassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: newCourseForm(),
            ),
            ElevatedButton(
              child: Text('Go back!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}
