import 'package:e_class/pages/students/widgets/individual_subject_button.dart';
import 'package:flutter/material.dart';

class Subject extends StatelessWidget {
   const Subject(this.subjectId,{super.key});
   final int subjectId;

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
    return  SizedBox(
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
    );
}
}