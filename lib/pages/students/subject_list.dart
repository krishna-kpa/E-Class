import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/subject_buttons.dart';
import 'package:e_class/data/subjects.dart';

// ignore: must_be_immutable
class SubjectList extends StatelessWidget{
  SubjectList(this.sem,this.schemeId,this.userId,this.userType, {super.key});

  int sem;
  int schemeId;
  String userId;
  int userType;

  List<Widget> showSubjects(schemeValue,semId,userId,userType){
    List<Widget> subjectsAvailable = [];
    for(var i =0;i<subjectList.length;i++){
      if(subjectList[i].schemeId == schemeValue && subjectList[i].semester == semId){
        subjectsAvailable.add(SubjectButton(subjectList[i].id,subjectList[i].subjectName,userId,userType));
      }
    }
    return subjectsAvailable;
  }

  @override
  Widget build(context){
    return  Scaffold(
      appBar: CommonAppBar("Subjects", 'S$sem', userType, userId),
      body: SizedBox(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [const SizedBox(height: 100,width: 10,),...showSubjects(schemeId,sem,userId,userType)],
              ),),
        ),
      ),
    );
  }
}