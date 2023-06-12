import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/teacher_button.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class TeachersList extends StatelessWidget{
  TeachersList(this.subject,this.user,{super.key});

  var subject;
  var user;

  Future<List<Widget>> showTeachers(subject) async {
      List<Widget> availableTeachers=[];
      var db = await mongo.Db.create("mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
      await db.open();
      mongo.DbCollection createdSubjects;
      createdSubjects = db.collection("subjects_created");
      print(createdSubjects);
      var v = await createdSubjects.find({'detailsId':subject['_id']}).toList();
      print(v);
      db.close();
      for(var i=0;i<v.length;i++){
        availableTeachers.add(TeacherButton(v[i], subject['subjectName'], v[i]['teacherId']));
      }
      return availableTeachers;
  }

  

  @override
  Widget build(context){
    return  Scaffold(
      appBar: CommonAppBar("Teachers",subject['subjectName'],user),
      body: Center(
        child: SizedBox(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            child: Container(
                child: FutureBuilder<List<Widget>>(
                future: showTeachers(subject),
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
                          ),
              ),),
          ),
        ),
    );
  }
}