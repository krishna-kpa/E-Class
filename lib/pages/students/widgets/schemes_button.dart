import 'package:e_class/pages/students/semester_list.dart';
import 'package:flutter/material.dart';

class SchemeButton extends StatelessWidget {
  const SchemeButton(this.schemeValue,this.schemeId, {super.key});

  final int schemeValue;
  final int schemeId;

  void schemeRouter(context,schemeId) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SemesterList(schemeId)));
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
              onPressed: () => schemeRouter(context,schemeId),
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
              child: Text(schemeValue.toString(),style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
