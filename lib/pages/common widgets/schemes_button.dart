import 'package:e_class/pages/students/semester_list.dart';
import 'package:flutter/material.dart';

class SchemeButton extends StatelessWidget {
  const SchemeButton(this.schemeValue,this.schemeId,this.userId,this.userType ,{super.key});
  
  final int userType;
  final int schemeValue;
  final int schemeId;
  final String userId;

  void schemeRouter(context,schemeId,userId,userType) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SemesterList(schemeId,userId,userType)));
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
              onPressed: () => schemeRouter(context,schemeId,userId,userType),
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
