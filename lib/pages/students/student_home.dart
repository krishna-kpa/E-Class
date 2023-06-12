import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/home_button.dart';

// ignore: must_be_immutable
class StudentHome extends StatelessWidget {
  StudentHome(this.user,{super.key});
  var user;
  @override
  Widget build(context) {
    return Scaffold(
        appBar: CommonAppBar("E Class", user["name"],user),
        body:   Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [HomeButton("Classrooms",user), HomeButton("My Classroom",user)],
                    ),
            )));
  }
}
