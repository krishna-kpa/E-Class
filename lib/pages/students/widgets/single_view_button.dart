import 'package:flutter/material.dart';
import 'package:e_class/data/notes.dart';
import 'package:e_class/data/assignments.dart';
import 'package:e_class/data/textbooks.dart';

class SingleViewButton extends StatelessWidget {
  const SingleViewButton(this.subjectId,this.id ,this.value,{super.key});

  final int subjectId;
  final String value;
  final int id;

  void subjectRouter(context,heading,id) {
    // ignore: unused_local_variable
    dynamic data;
    List collections ;
    if(heading=='Notes'){
      collections = notes;
    }else if(heading=='Textbooks'){
      collections = textbooks;
    }else if(heading=='Assignments'){
      collections = assignments;
    }else{
      collections = [1];
    }
    for(var i=0;i<collections.length;i++){
      if(collections[i].id==id){
        data = collections[i];
        break;
      }
    }
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => const Text("data")));
  }
  String nameOfTask(subjectId,heading,id){
    List collections ;
    var data;
    if(heading=='Notes'){
      collections = notes;
    }else if(heading=='Textbooks'){
      collections = textbooks;
    }else if(heading=='Assignments'){
      collections = assignments;
    }else{
      collections = [1];
    }
    for(var i=0;i<collections.length;i++){
      if(collections[i].id==id){
        data = collections[i];
        break;
      }
    }
    return data.name;
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
              onPressed: () => subjectRouter(context,value,subjectId),
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
              child: Text(nameOfTask(subjectId,value,id),style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
