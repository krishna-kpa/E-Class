import 'package:flutter/material.dart';
import 'package:e_class/pages/students/my_classroom.dart';
import 'package:e_class/pages/students/classrooms.dart';


class HomeButton extends StatelessWidget {
  const HomeButton(this.homeOption, {super.key});
  final String homeOption;
  Future<void> homeRouter(context, homeOption) async {
    if (homeOption == 'My Classroom') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MyClassroom()));
    } else if (homeOption == 'Classrooms') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Classrooms()));
    }
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: SizedBox(
          width: double.infinity,
          height: 100,
          child: ElevatedButton(
            onPressed: () => homeRouter(context, homeOption),
            style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 96, 49, 49),
                ),
                backgroundColor: const Color.fromARGB(154, 255, 240, 182),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: Text(homeOption,
                style: const TextStyle(
                  color: Color.fromRGBO(118, 82, 71, 1),
                  fontSize: 25,
                )),
          )),
    );
  }
}
