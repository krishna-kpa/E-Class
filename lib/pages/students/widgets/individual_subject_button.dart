import 'package:e_class/pages/students/module_view.dart';
import 'package:flutter/material.dart';

class IndividualButton extends StatelessWidget {
  const IndividualButton(this.subjectId,this.value ,{super.key});

  final int subjectId;
  final String value;
  

  void subjectRouter(context,value,subjectId) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => ModuleList(value, subjectId)));
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
              child: Text(value,style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
