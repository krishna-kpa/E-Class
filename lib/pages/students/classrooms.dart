import 'package:flutter/material.dart';
import 'package:e_class/pages/students/components/schemes_button.dart';
import 'package:e_class/data/schemes.dart';

class Classrooms extends StatelessWidget{
  const Classrooms({super.key});

  List<Widget> showSchemes(){
    List<Widget> schemsAvailable = [];
    for(var i =0;i<schemeList.length;i++){
      schemsAvailable.add(SchemeButton(schemeList[i].schemeName,schemeList[i].id));
    }
    return schemsAvailable;
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
          children: [const SizedBox(height: 100,width: 10,),...showSchemes()],
            ),),
      ),
    );
  }
}