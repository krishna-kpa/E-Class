import 'package:e_class/pages/common%20widgets/file_view.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:e_class/pages/teachers/not_submitted.dart';
import 'package:e_class/pages/teachers/submitted_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AssignmentView extends StatelessWidget {
  AssignmentView(this.content,this.user,{super.key});
  var content;
  var user;

  void moduleRouter(context,value) {
    if(value==0){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => FileViewPage(content['id'])));
    }else if(value==1){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SubStudentList(content, user)));
    }else{
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => NotSubStudentList(content, user)));
    }

  }

  @override
  Widget build(context) {
    return Scaffold(appBar: CommonAppBar(content['name'], '', user),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Container(
              margin:const  EdgeInsets.only(left: 10,right: 10),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => moduleRouter(context,0),
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
                    child: const Text("Question",style: TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
                    
                  )),
            ),
          ),Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Container(
              margin:const  EdgeInsets.only(left: 10,right: 10),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => moduleRouter(context,1),
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
                    child: const Text("Submitted Students",style: TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
                    
                  )),
            ),),Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Container(
              margin:const  EdgeInsets.only(left: 10,right: 10),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => moduleRouter(context,2),
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
                    child: const  Text("Not Submitted Students",style: TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
                    
                  )),
            ))
        ],
      ),
    );
  }
}
