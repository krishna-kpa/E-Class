import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Teachers extends StatefulWidget {
  final subjectId;
  final user;
  Teachers(this.subjectId, this.user, {Key? key});

  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  Future<List<Widget>> showTeacherNames() async {
    List<Widget> teacherWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection teacherCollection = db.collection("subjects_created");
    var teachers =
        await teacherCollection.find({'id': widget.subjectId}).toList();

    mongo.DbCollection userCollection = db.collection("users");

    for (var teacher in teachers) {
      String teacherId = teacher['teacherId'];

      var teacherData = await userCollection.findOne({'id': teacherId});

      if (teacherData != null) {
        String teacherName = teacherData['name'];

        teacherWidgets.add(
          Container(
            margin: EdgeInsets.all(25.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(154, 255, 240, 182),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.brown,
                width: 2.0,
              ),
            ),
            child: Center(
              child: Text(
                '$teacherId - $teacherName',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        );
      }
    }

    db.close();

    return teacherWidgets;
  }

  Future<void> reloadData() async {
    setState(() {}); // Trigger a rebuild of the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Teacher List', ' ', widget.user),
      body: Center(
        child: FutureBuilder<List<Widget>>(
          future: showTeacherNames(),
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
    );
  }
}
