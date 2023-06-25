import 'package:e_class/pages/common%20widgets/file_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SSubButton extends StatelessWidget {
  SSubButton(this.content,this.user,{super.key});

  var content;
  var user;
  

  void moduleRouter(context,content,user) {
    if(content==0){
    }else{


    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => FileViewPage(content['id'])));
    }
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
              onPressed: () => moduleRouter(context,content,user),
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
              child: Text(user['name'],style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
