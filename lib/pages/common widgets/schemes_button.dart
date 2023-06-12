import 'package:e_class/pages/students/semester_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SchemeButton extends StatelessWidget {
  SchemeButton(this.scheme,this.user,{super.key});
  
  var scheme;
  var user;

  void schemeRouter(context,schemeId,user) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SemesterList(schemeId,user)));
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
              onPressed: () => schemeRouter(context,scheme["name"],user),
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
              child: Text(scheme['name'].toString(),style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
