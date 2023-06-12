
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:e_class/pages/students/components/my_subjects.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class StudentMyClassroom extends StatelessWidget{
  StudentMyClassroom(this.user,{super.key});
  var user;

  Future<List<Widget>> findSubjects(user) async {
      List<Widget> availableSubject=[];
      var db = await mongo.Db.create("mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
      await db.open();
      mongo.DbCollection subject;
      subject = db.collection("subjects_created");
      print(subject);
      var v = await subject.find({'assignedBatchId':user['batchId']}).toList();
      print(v);
      db.close();
      for(var i=0;i<v.length;i++){
        availableSubject.add(SSubjectButton(user, v[i]));
      }
      return availableSubject;
  }
  

  @override
  Widget build(context){
    return  Scaffold(
      appBar: CommonAppBar("My Classroom", "",user),
      body: SizedBox(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: Center(
            child: Container(
              child: FutureBuilder<List<Widget>>(
              future: findSubjects(user),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return snapshot.data![index];
                    },
                  );
                } else {
                  return const Text('No data');
                }
              },
            ),),
          ),
        ),
      ),
    );
  }
}