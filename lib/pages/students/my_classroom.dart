
import 'package:e_class/data/subjects_created.dart';
import 'package:e_class/data/users.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:e_class/pages/students/components/my_subjects.dart';
import 'package:flutter/material.dart';

class StudentMyClassroom extends StatelessWidget{
  const StudentMyClassroom(this.id,{super.key});
  final String id;

  List<Widget> findMySubjects(String id){
    int batchId = 0;

    for(var i=0;i<students.length;i++){
      if(students[i].id==id){
        batchId = students[i].batchId;
        break;
      }
    }
    List<Widget> mySubjects =[];
    for(var i =0;i<subjectsCreated.length;i++){
        if(subjectsCreated[i].assignedBatchId==batchId){
            mySubjects.add(SSubjectButton(subjectsCreated[i].detailsId, subjectsCreated[i].teachersId));
        }
    }
    return mySubjects;
  }

  @override
  Widget build(context){
    return  Scaffold(
      appBar: CommonAppBar("My Classroom", "", 2, id),
      body: SizedBox(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [const SizedBox(height: 100,width: 10,),...findMySubjects(id)],
              ),),
        ),
      ),
    );
  }
}