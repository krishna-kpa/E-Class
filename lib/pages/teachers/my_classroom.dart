import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:e_class/pages/teachers/my_subjects.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/teachers/add_subject.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class TeacherMyClassroom extends StatelessWidget {
  final dynamic user;

  const TeacherMyClassroom(this.user, {Key? key}) : super(key: key);

  Future<List<Widget>> findSubjects(dynamic user) async {
    final availableSubjects = <Widget>[];

    final db = await mongo.Db.create(
      "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority",
    );
    await db.open();
    final subjectCollection = db.collection("subjects_created");

    final v = await subjectCollection.find({'teacherId': user['id']}).toList();

    for (var i = 0; i < v.length; i++) {
      availableSubjects.add(TSubjectButton(user, v[i]));
    }

    db.close();
    return availableSubjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("My Classroom", "", user),
      body: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: FutureBuilder<List<Widget>>(
          future: findSubjects(user),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => snapshot.data![index],
              );
            } else {
              return const Center(child: Text('No data'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSubject(user)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
