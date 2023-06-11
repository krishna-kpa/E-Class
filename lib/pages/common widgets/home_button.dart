import 'package:e_class/pages/login.dart';
import 'package:e_class/pages/teachers/my_classroom.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/students/my_classroom.dart';
import 'package:e_class/pages/students/classrooms.dart';


class HomeButton extends StatelessWidget {
  const HomeButton(this.homeOption,this.id,this.type, {super.key});
  final String homeOption;
  final String id;
  final int type;
  Future<void> homeRouter(context, homeOption,id,type) async {
    if (homeOption == 'My Classroom') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            if(type==1){
              return TeacherMyClassroom(id);
            }else if(type==2){
              return StudentMyClassroom(id);
            }else{
              return const Login();
            }
          }));
    } else if (homeOption == 'Classrooms') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  Classrooms(id,type)));
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
            onPressed: () => homeRouter(context, homeOption,id,type),
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
