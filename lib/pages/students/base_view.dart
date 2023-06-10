import 'package:flutter/material.dart';
import 'package:e_class/data/notes.dart';
import 'package:e_class/data/assignments.dart';
import 'package:e_class/data/textbooks.dart';
import 'package:e_class/pages/common widgets/single_view_button.dart';

class BaseView extends StatelessWidget {
  const BaseView(this.heading,this.subjectId,{super.key});
  final String heading;
  final int subjectId;
  List<Widget> showContent(heading,id){
    List collections;
    List<Widget> contents=[];
    if(heading=='Notes'){
      collections = notes;
    }else if(heading=='Textbooks'){
      collections = textbooks;
    }else if(heading=='Assignments'){
      collections = assignments;
    }else{
      collections = [1];
    }
    for(var i = 0;i<collections.length;i++){
      contents.add(SingleViewButton(subjectId,heading,collections[i].id));
    }
    return contents;
  }
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(heading),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: showContent(heading,subjectId),
                    ),
            )));
  }
}
