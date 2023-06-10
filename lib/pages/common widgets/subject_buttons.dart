import 'package:flutter/material.dart';
import 'package:e_class/pages/students/teacher_list.dart';

class SubjectButton extends StatelessWidget {
  const SubjectButton(this.subjectId,this.subjectName, {super.key});

  final int subjectId;
  final String subjectName;
  

  void subjectRouter(context,subjectId,subjectName) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => TeachersList(subjectId, subjectName)));
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
              onPressed: () => subjectRouter(context,subjectId,subjectName),
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
              child: Text(subjectName,style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
