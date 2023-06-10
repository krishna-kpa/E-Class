import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/teacher_button.dart';
import 'package:e_class/data/subjects_created.dart';

// ignore: must_be_immutable
class TeachersList extends StatelessWidget{
  TeachersList(this.subjectId,this.subjectName,{super.key});

  int subjectId;
  String subjectName;

  List<Widget> showTeachers(subjectId,subjectName){
    List<Widget> teachersAvailable = [];
    for(var i =0;i<subjectsCreated.length;i++){
      if(subjectsCreated[i].detailsId == subjectId ){
        teachersAvailable.add(TeacherButton(subjectsCreated[i].id, subjectName, subjectsCreated[i].teachersId));
      }
    }
    return teachersAvailable;
  }

  @override
  Widget build(context){
    return  SizedBox(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [const SizedBox(height: 100,width: 10,),...showTeachers(subjectId,subjectName)],
            ),),
      ),
    );
  }
}