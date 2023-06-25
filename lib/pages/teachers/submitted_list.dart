import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:e_class/pages/teachers/sub_button.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class SubStudentList extends StatelessWidget {
  SubStudentList(this.content, this.user, {super.key});

  var content;
  var user;

  Future<List<Widget>> showStudents(content, user) async {
    List<Widget> availableModules = [];
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();
    mongo.DbCollection details;
    mongo.DbCollection indAssignment;
    details = db.collection("users");
    indAssignment = db.collection('submitted_assignments');
    print(details);
    for (var i = 0; i < content['submittedStudents'].length; i++) {
      var tempU = await details.findOne({'id':content['submittedStudents'][i]});
      var temp = await indAssignment.findOne({'assignmentId':content['_id'],'studentId':content['submittedStudents'][i]});
      availableModules
          .add(SSubButton(temp, tempU));
    }
    return availableModules;
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: CommonAppBar('Submitted Students', '', user),
      body: Center(
        child: SizedBox(
          child: Center(
            child: Container(
              child: FutureBuilder<List<Widget>>(
                future: showStudents(content, user),
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
            ),
          ),
        ),
      ),
    );
  }
}
