import 'package:e_class/pages/common widgets/individual_subject_button.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SSubject extends StatelessWidget {
  SSubject(this.subject,this.user,{super.key});
  var subject;
  var user;

   List<Widget> showOptions(subject,user){
    List<String> options = ["Notes","Textbooks","Assignments","Chatroom"];
    List<Widget> availableOptions = [];

    for(var i=0;i<options.length;i++){
      availableOptions.add(IndividualButton(subject, options[i],user));
    }
    return availableOptions;

   }

  @override
  Widget build(context) {
    return  Scaffold(
      appBar: CommonAppBar('', '',user),
      body:SizedBox(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [...showOptions(subject,user)],
              ),),
        ),
      ),
    )
    );
}
}