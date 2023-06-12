import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/semester_button.dart';

// ignore: must_be_immutable
class SemesterList extends StatelessWidget {
  SemesterList(this.schemeId,this.user,  {super.key});
  final int schemeId;
  var user;
   
  List<Widget> semesterButtons(schemeId,user) {
    int sem=0;
    List<Widget> semesterButton = [];
    for (var i = 0; i < 4; i++) {
      semesterButton.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            SemesterButton(schemeId, sem + 1,user),
            SemesterButton(schemeId, sem + 2,user),
            const SizedBox(
              width: 10,
            )
          ]));
          sem+=2;
    }
    return semesterButton;
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: CommonAppBar("Semesters", ' ', user),
      body: SizedBox(
          child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: semesterButtons(schemeId,user),
        ),
      )),
    );
  }
}
