import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/home_button.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('E-Class'),
        ),
        body:  const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [HomeButton("Classrooms"), HomeButton("My Classroom")],
                    ),
            )));
  }
}
