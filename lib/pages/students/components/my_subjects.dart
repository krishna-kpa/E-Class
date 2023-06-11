import 'package:e_class/data/subjects.dart';
import 'package:flutter/material.dart';

class SSubjectButton extends StatelessWidget {
  const SSubjectButton(this.subjectId,this.teacherId,{super.key});

  final int subjectId;
  final String teacherId;
  

  void subjectRouter(context,subjectId,subjectName) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => Text(subjectId.toString()+subjectName)));
  }

  String findSubjectName(subjectId){
  for(var i=0;i<subjectList.length;i++){
    if(subjectList[i].id==subjectId){
      return subjectList[i].subjectName;
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
              onPressed: () => subjectRouter(context,subjectId,teacherId),
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
              child: Text(findSubjectName(subjectId),style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
