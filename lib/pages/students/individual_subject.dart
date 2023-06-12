import 'package:e_class/pages/common widgets/individual_subject_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Subject extends StatelessWidget {
   Subject(this.subject,{super.key});
   var subject;
   List<Widget> showOptions(subject){
    List<String> options = ["Notes","Textbooks","Assignments","Chatroom"];
    List<Widget> availableOptions = [];

    for(var i=0;i<options.length;i++){
      availableOptions.add(IndividualButton(subject, options[i]));
    }
    return availableOptions;

   }

  @override
  Widget build(context) {
    return  Scaffold(
      body: Center(
        child: SizedBox(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [...showOptions(subject)],
                ),),
        ),
      ),
    );
}
}