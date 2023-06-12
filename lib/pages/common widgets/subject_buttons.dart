import 'package:flutter/material.dart';
import 'package:e_class/pages/students/teacher_list.dart';

// ignore: must_be_immutable
class SubjectButton extends StatelessWidget {
  SubjectButton(this.subject,this.user, {super.key});

  var subject;
  var user;
  

  void subjectRouter(context,subject,user) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => TeachersList(subject,user)));
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: Container(
        margin:const  EdgeInsets.only(left: 10,right: 10),
        child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => subjectRouter(context,subject,user),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 96, 49, 49),
                ),
                backgroundColor:const Color.fromARGB(154, 255, 240, 182),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              child: Text(subject['subjectName'],style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
