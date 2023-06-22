import 'package:flutter/material.dart';
import 'admin_subjectlist.dart';

// ignore: must_be_immutable
class AdminSemesterButton extends StatelessWidget {
  AdminSemesterButton(this.schemeId, this.sem, this.user, {super.key});

  final int schemeId;
  final int sem;
  var user;

  void semesterRouter(context, schemeId, value, user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdminSubjectList(value, schemeId, user)));
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
            width: 150,
            height: 100,
            child: ElevatedButton(
              onPressed: () => semesterRouter(context, schemeId, sem, user),
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 96, 49, 49),
                  ),
                  backgroundColor: const Color.fromARGB(154, 255, 240, 182),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Text("$sem",
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20,
                  )),
            )),
      ),
    );
  }
}
