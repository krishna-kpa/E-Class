import 'package:e_class/pages/students/single_view.dart';
import 'package:flutter/material.dart';

class ModuleButton extends StatelessWidget {
  const ModuleButton(this.value,this.subjectId,this.subjectName,this.heading, {super.key});

  final int subjectId;
  final String subjectName;
  final int value;
  final String heading;
  

  void moduleRouter(context,subjectId,subjectName,moduleNo) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SingleView(heading, subjectId,moduleNo)));
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
              onPressed: () => moduleRouter(context,subjectId,subjectName,value),
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
              child: Text("Module $value",style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
