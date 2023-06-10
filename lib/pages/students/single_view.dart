import 'package:flutter/material.dart';
import 'package:e_class/data/notes.dart';
import 'package:e_class/data/assignments.dart';
import 'package:e_class/data/textbooks.dart';
import 'package:e_class/pages/common widgets/single_view_button.dart';

class SingleView extends StatelessWidget {
  const SingleView(this.heading,this.subjectId,this.moduleNo,{super.key});
  final String heading;
  final int subjectId;
  final int moduleNo;
  List<Widget> showContent(heading,id,moduleNo){
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
      if(collections[i].moduleNo==moduleNo && collections[i].subjectId == subjectId){
        contents.add(SingleViewButton(id,collections[i].id,heading));
      }
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
              children: showContent(heading,subjectId,moduleNo),
                    ),
            )));
  }
}
