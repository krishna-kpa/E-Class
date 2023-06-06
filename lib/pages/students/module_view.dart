import 'package:e_class/data/subjects.dart';
import 'package:e_class/pages/students/widgets/module_button.dart';
import 'package:flutter/material.dart';
import 'package:e_class/data/subjects_created.dart';

// ignore: must_be_immutable
class ModuleList extends StatelessWidget{
  ModuleList(this.value,this.subjectId,{super.key});

  String value;
  int subjectId;

  List<Widget> showModules(value,subjectId){
    List<Widget> availableModules = [];
    int detailsId=0;
    int noOfModules=0;
    String subjectName ='';
    for(var i =0;i<subjectsCreated.length;i++){
      if(subjectsCreated[i].id==subjectId){
        detailsId = subjectsCreated[i].detailsId;
      }
    }
    for(var i =0;i<subjectList.length;i++){
      if(subjectList[i].id==detailsId){
        noOfModules = subjectList[i].noOfModules;
        subjectName = subjectList[i].subjectName;
      }
    }
    for(var i =0;i<noOfModules;i++){
      availableModules.add(ModuleButton(i+1,subjectId, subjectName,value));
    }

    return availableModules;
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
          children: [const SizedBox(height: 100,width: 10,),...showModules(value,subjectId)],
            ),),
      ),
    );
  }
}