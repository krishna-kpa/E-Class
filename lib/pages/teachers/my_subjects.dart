import 'package:e_class/pages/students/s_subject.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class TSubjectButton extends StatelessWidget {
  TSubjectButton(this.user,this.subject,{super.key});
  var user;
  var subject;
  

  void subjectRouter(context,subject,user) {
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => Text("data")));
  }

  Future<String> findSubjectName(subject) async{
      var db = await mongo.Db.create("mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
      await db.open();
      mongo.DbCollection subjects;
      mongo.DbCollection teachers;
      subjects = db.collection("subjects");
      print(subjects);
      var v = await subjects.findOne({'_id':subject['detailsId']});
      print(v);
      db.close();
      return v!['subjectName']+" - "+subject['assignedBatchId'].toString();
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
              onPressed: () => subjectRouter(context,subject,user),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 96, 49, 49),
                ),
                backgroundColor:const Color.fromARGB(154, 255, 240, 182),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
              ),
              child:FutureBuilder<String>(
      future: findSubjectName(subject),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while waiting for the future to complete
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show an error message if the future throws an error
        } else {
          return Text(snapshot.data ?? 'No data',style: const TextStyle(color:Color.fromRGBO(0, 0, 0, 1),fontSize: 20,),textAlign: TextAlign.center,); // Display the data once the future completes
        }
      },
      )
    )),
      ),
    );
  }
}
