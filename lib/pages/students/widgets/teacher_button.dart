import 'package:e_class/pages/students/individual_subject.dart';
import 'package:flutter/material.dart';
import 'package:e_class/data/teachers.dart';

class TeacherButton extends StatelessWidget {
  const TeacherButton(this.subjectId,this.subjectName,this.teacherId, {super.key});

  final int subjectId;
  final String subjectName;
  final int teacherId;
  

  void teacherRouter(context,subjectId) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => Subject(subjectId)));
  }

  String teacherName(teacherId,teacherList){
    for(var i = 0; i< teacherList.length;i++){
      if(teacherList[i].id == teacherId){
        return teacherList[i].teacherName;
      }
    }
    return '';
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
              onPressed: () => teacherRouter(context,subjectId),
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
              child: Text(teacherName(teacherId,teacherList),style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
