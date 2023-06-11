import 'package:e_class/pages/students/subject_list.dart';
import 'package:flutter/material.dart';

class SemesterButton extends StatelessWidget {
  const SemesterButton(this.schemeId,this.sem,this.userId,this.userType, {super.key});

  final int schemeId;
  final int sem;
  final String userId;
  final int userType;

  void semesterRouter(context,schemeId,value,userId,userType) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SubjectList(value,schemeId,userId,userType)));
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: Container(
        margin:const  EdgeInsets.only(left: 10,right: 10),
        child: SizedBox(
            width: 150,
            height: 100,
            child: ElevatedButton(
              onPressed: () => semesterRouter(context,schemeId,sem,userId,userType),
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
              child: Text("Sem-$sem",style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
