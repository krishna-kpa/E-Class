import 'package:e_class/pages/common%20widgets/file_upload.dart';
import 'package:e_class/pages/common%20widgets/file_view.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class AssignmentView extends StatelessWidget {
  AssignmentView(this.assignment, this.user, {super.key});
  var user;
  var assignment;
  viewQuestion(assignmentId, context) {
    print("view question" + assignmentId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FileViewPage(assignmentId.toString())));
  }

  checkAndRoute(context, user, assignmentId) async {
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();
    mongo.DbCollection avSubjects;
    avSubjects = db.collection("assignment");
    print(avSubjects);
    var v = await avSubjects.findOne({'id': assignmentId});
    print(v);
    db.close();

    if (v != null && v['submittedStudents'] != null) {
      for (var i = 0; i < v['submittedStudents'].length; i++) {
        if (v['submittedStudents'][i] == user['id']) {
          var db = await mongo.Db.create(
              "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
          await db.open();
          mongo.DbCollection submittedAssignments;
          submittedAssignments = db.collection("submitted_assignments");
          print(v['_id'].toString() + ' ' + user['id'].toString());
          var temp = await submittedAssignments
              .findOne({'assignmentId': v['_id'], 'studentId': user['id']});
          print(temp);
          db.close();
          if (temp != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FileViewPage(temp['id'])));
            return;
          }
        }
      }
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) {
          return FileUploadPage(v,user);
        }));
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: CommonAppBar(assignment['name'].toString(), '', user),
        body: SizedBox(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () =>
                              {viewQuestion(assignment['id'], context)},
                                        
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 96, 49, 49),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(154, 255, 240, 182),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                            
                          child:  const Text(
                            "View Question",
                            style: TextStyle(color:Color.fromARGB(255, 96, 49, 49)),
                          ),
                        ),
                      ),
                    ),
                        const SizedBox(
                            height: 30,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () =>
                                {checkAndRoute(context, user, assignment['id'])},
                                style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 96, 49, 49),
                                      ),
                                      backgroundColor: const Color.fromARGB(154, 255, 240, 182),
                                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                            child: const Text("View Submission",
                            style: TextStyle(color: Color.fromARGB(255, 96, 49, 49)))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
