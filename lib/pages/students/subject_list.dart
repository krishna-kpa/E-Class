import 'package:flutter/material.dart';
import 'package:e_class/pages/students/components/subject_buttons.dart';
import 'package:e_class/data/subjects.dart';

// ignore: must_be_immutable
class SubjectList extends StatelessWidget{
  SubjectList(this.id,this.schemeId,{super.key});

  int id;
  int schemeId;

  List<Widget> showSubjects(schemeValue,semId){
    List<Widget> subjectsAvailable = [];
    for(var i =0;i<subjectList.length;i++){
      if(subjectList[i].schemeId == schemeValue && subjectList[i].semester == semId){
        subjectsAvailable.add(SubjectButton(subjectList[i].id,subjectList[i].subjectName));
      }
    }
    return subjectsAvailable;
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
          children: [const SizedBox(height: 100,width: 10,),...showSubjects(schemeId,id)],
            ),),
      ),
    );
  }
}