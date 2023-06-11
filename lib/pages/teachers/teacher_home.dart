import 'package:e_class/pages/common%20widgets/home_button.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome(this.teacherId, {super.key});
  final String teacherId;
  @override
  Widget build(context) {
    return Scaffold(
      appBar: CommonAppBar('E Class', teacherId, 2, teacherId),
        body:    Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [HomeButton("Classrooms",teacherId,1), HomeButton("My Classroom",teacherId,1)],
                    ),
            ))
      
    );
  }
}
