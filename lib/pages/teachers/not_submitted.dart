import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:e_class/pages/teachers/sub_button.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class NotSubStudentList extends StatelessWidget {
  NotSubStudentList(this.content, this.user, {Key? key}) : super(key: key);

  var content;
  var user;

  Future<List<Widget>> showStudents(content, user) async {
    List<Widget> availableModules = [];
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();
    mongo.DbCollection details;
    mongo.DbCollection sCreated;
    details = db.collection("users");
    sCreated = db.collection('subjects_created');
    var sub = await sCreated.findOne({'_id': content['subjectId']});
    var batch = sub?['assignedBatchId'];
    print('mydata'+sub.toString());
    if (batch != null) {
      var users = await details.find({'batchId': batch}).toList();
      print(users.toString());
      for (var i = 0; i < users.length; i++) {
        if (content['submittedStudents'].contains(users[i]['id'])) {
          continue;
        }else{
          availableModules.add(SSubButton(0, users[i]));
        }
      }
    } else {
      // Handle the case when `sub` or `batch` is null
    }
    return availableModules;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Not Submitted Students', '', user),
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
