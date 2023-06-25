import 'package:e_class/pages/students/module_view.dart';
import 'package:e_class/pages/students/single_view.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class IndividualButton extends StatelessWidget {
  IndividualButton(this.subject,this.value ,this.user,{super.key});

  var subject;
  final String value;
  var user;
  

  void subjectRouter(context,value,subjectId,user) async {
    if(value=='Chatroom'){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => ModuleList(value, subject,user)));
    }
    else if(value=='Textbooks'){
      
      var db = await mongo.Db.create("mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
      await db.open();
      mongo.DbCollection details;
      details = db.collection("subjects");
      print(details);
      var v = await details.findOne({'_id':subject['detailsId']});
      print(v);
      db.close();
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SingleView("Textbooks", subject, 0, user)));
    }
    else{
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => ModuleList(value, subject,user)));
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
              onPressed: () => subjectRouter(context,value,subject,user),
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
              child: Text(value,style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,)),
              
            )),
      ),
    );
  }
}
