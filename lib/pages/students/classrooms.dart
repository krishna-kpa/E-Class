import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets//schemes_button.dart';
import 'package:e_class/data/schemes.dart';

class Classrooms extends StatelessWidget{
  const Classrooms(this.userId,this.userType,{super.key});

  final int userType;
  final String userId;

  List<Widget> showSchemes(userId,userType){
    List<Widget> schemsAvailable = [];
    for(var i =0;i<schemeList.length;i++){
      schemsAvailable.add(SchemeButton(schemeList[i].schemeName,schemeList[i].schemeName,userId,userType));
    }
    return schemsAvailable;
  }

  @override
  Widget build(context){
    return  Scaffold(
      appBar: CommonAppBar('Schemes', ' ', userType, userId),
      body: SizedBox(
        child: DecoratedBox( 
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [const SizedBox(height: 100,width: 10,),...showSchemes(userId,userType)],
              ),),
        ),
      ),
    );
  }
}