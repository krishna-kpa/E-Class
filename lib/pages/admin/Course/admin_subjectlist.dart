import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'admin_create_subject.dart';
import 'Teacher_list.dart';

class AdminSubjectList extends StatefulWidget {
  final int schemeId;
  final int sem;
  final user;
  AdminSubjectList(this.sem, this.schemeId, this.user, {Key? key});

  @override
  _AdminSubjectListState createState() => _AdminSubjectListState();
}

class _AdminSubjectListState extends State<AdminSubjectList> {
  Future<List<Widget>> showSubjects() async {
    List<Widget> subjectNameWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection subjectCollections = db.collection("subjects");
    var subjects = await subjectCollections
        .find({'schemeId': widget.schemeId, 'semester': widget.sem}).toList();

    db.close();

    for (var subject in subjects) {
      String subjectName = subject['subjectName'];
      int subId = subject['id'];

      subjectNameWidgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: SizedBox(
            width: 150,
            height: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 96, 49, 49),
                ),
                backgroundColor: Color.fromARGB(154, 255, 240, 182),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Teachers(subId, widget.user),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        deleteSubject(subjectName, subId);
                      },
                      icon: Icon(Icons.delete, color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      '$subjectName',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return subjectNameWidgets;
  }

  Future<void> deleteSubject(String subjectName, subId) async {
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection subjectsCollection = db.collection("subjects");
    mongo.DbCollection subjects_createdCollection =
        db.collection("subjects_created");
    await subjectsCollection.remove(mongo.where.eq('subjectName', subjectName));
    await subjects_createdCollection.remove(mongo.where.eq('id', subId));

    db.close();

    // Reload the page after deleting the batch
    await reloadData();
  }

  Future<void> reloadData() async {
    setState(() {}); // Trigger a rebuild of the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Subject List', ' ', widget.user),
      body: Center(
        child: FutureBuilder<List<Widget>>(
          future: showSubjects(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateSub(widget.schemeId, widget.sem, widget.user),
            ),
          );

          // Reload the page after returning from CreateBatch
          await reloadData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
