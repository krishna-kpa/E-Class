import 'package:e_class/pages/login.dart';
import 'package:e_class/pages/teachers/my_classroom.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/students/my_classroom.dart';
import 'package:e_class/pages/students/classrooms.dart';


// ignore: must_be_immutable
class HomeButton extends StatelessWidget {
  HomeButton(this.homeOption,this.user, {super.key});
  final String homeOption;
  var user;
  Future<void> homeRouter(context, homeOption,id,type) async {
    if (homeOption == 'My Classroom') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            if(type==1){
              return TeacherMyClassroom(user);
            }else if(type==2){
              return StudentMyClassroom(user);
            }else{
              return const Login();
            }
          }));
    } else if (homeOption == 'Classrooms') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  Classrooms(user)));
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
            onPressed: () => homeRouter(context, homeOption,user['id'],user['type']),
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
