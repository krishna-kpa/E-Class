import 'package:e_class/pages/common%20widgets/home_button.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TeacherHome extends StatelessWidget {
  TeacherHome(this.teacher, {super.key});
  var teacher;
  @override
  Widget build(context) {
    return Scaffold(
      appBar: CommonAppBar('E Class', teacher["id"], teacher),
        body:    Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [HomeButton("Classrooms",teacher), HomeButton("My Classroom",teacher)],
                    ),
            ))
      
    );
  }
}
