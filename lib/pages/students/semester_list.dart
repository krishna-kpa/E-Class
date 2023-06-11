import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/semester_button.dart';

class SemesterList extends StatelessWidget {
  const SemesterList(this.schemeId,this.userId,this.userType,  {super.key});
  final int userType;
  final int schemeId;
  final String userId;
   
  List<Widget> semesterButtons(schemeId,userId,userType) {
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
            SemesterButton(schemeId, sem + 1,userId,userType),
            SemesterButton(schemeId, sem + 2,userId,userType),
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
      appBar: CommonAppBar("Semesters", ' ', userType, userId),
      body: SizedBox(
          child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: semesterButtons(schemeId,userId,userType),
        ),
      )),
    );
  }
}
