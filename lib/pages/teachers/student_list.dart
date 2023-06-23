import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class StudentList extends StatefulWidget {
  final String batchyear;
  // ignore: prefer_typing_uninitialized_variables
  final user;

  StudentList(this.batchyear, this.user, {Key? key});
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  Future<List<Widget>> showStudentNames() async {
    List<Widget> studentNameWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection usersCollection = db.collection("users");
    var students = await usersCollection
        .find({'type': 2, 'batchId': widget.batchyear}).toList();

    db.close();

    for (var student in students) {
      String studentId = student['id'];
      String studentName = student['name'];

      studentNameWidgets.add(
        Container(
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(154, 255, 240, 182),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.brown,
              width: 2.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adm.no: $studentId',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name: $studentName',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return studentNameWidgets;
  }

  Future<void> reloadData() async {
    setState(() {}); // Trigger a rebuild of the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Student Names', ' ', widget.user),
      body: Center(
        child: FutureBuilder<List<Widget>>(
          future: showStudentNames(),
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
