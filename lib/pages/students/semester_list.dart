import 'package:flutter/material.dart';
import 'package:e_class/pages/students/widgets/semester_button.dart';

class SemesterList extends StatelessWidget {
  const SemesterList(this.schemeId, {super.key});

  final int schemeId;
   
  List<Widget> semesterButtons(schemeId) {
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
            SemesterButton(schemeId, sem + 1),
            SemesterButton(schemeId, sem + 2),
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
    return SizedBox(
        child: DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: semesterButtons(schemeId),
      ),
    ));
  }
}
