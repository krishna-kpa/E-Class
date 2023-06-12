import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/subject_buttons.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class SubjectList extends StatelessWidget {
  SubjectList(this.sem, this.schemeId, this.user, {Key? key})
      : super(key: key);

  final int sem;
  final int schemeId;
  var user;

  Future<List<Widget>> showSubjects(schemeValue, sem, user) async {
    List<Widget> availableSubjects = [];
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();
    mongo.DbCollection subjects;
    subjects = db.collection("subjects");
    print(subjects);
    var v = await subjects.find({'semester': sem,"schemeId":schemeValue}).toList();
    print(v);
    db.close();
    for (var i = 0; i < v.length; i++) {
      availableSubjects.add(SubjectButton(v[i], user));
    }
    return availableSubjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("Subjects", 'S$sem', user),
      body: Center(
        child: SizedBox(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white),
            child: FutureBuilder<List<Widget>>(
              future: showSubjects(schemeId, sem, user),
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
    );
  }
}
