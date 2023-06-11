import 'package:e_class/pages/common widgets/individual_subject_button.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';

class SSubject extends StatelessWidget {
   const  SSubject(this.subjectId,this.subjectName,this.teacherId,this.userId,{super.key});
   final int subjectId;
   final String subjectName;
   final String teacherId;
   final String userId;

   List<Widget> showOptions(subjectId){
    List<String> options = ["Notes","Textbooks","Assignments","Chatroom"];
    List<Widget> availableOptions = [];

    for(var i=0;i<options.length;i++){
      availableOptions.add(IndividualButton(subjectId, options[i]));
    }
    return availableOptions;

   }

  @override
  Widget build(context) {
    return  Scaffold(
      appBar: CommonAppBar(subjectName, teacherId, 2, userId),
      body:SizedBox(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [const SizedBox(height: 300,width: 10,),...showOptions(subjectId)],
            ),),
      ),
    )
    );
}
}