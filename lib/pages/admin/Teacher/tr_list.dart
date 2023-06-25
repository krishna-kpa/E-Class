import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:e_class/pages/admin/Teacher/tr_add.dart';

class TeacherList extends StatefulWidget {
  final user;

  TeacherList(this.user, {Key? key});

  @override
  _TeacherListState createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  Future<List<Widget>> showTeacherNames() async {
    List<Widget> teacherNameWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection usersCollection = db.collection("users");
    var teachers =
        await usersCollection.find(mongo.where.eq('type', 1)).toList();

    db.close();

    for (var teacher in teachers) {
      String teacherId = teacher['id'];
      String teacherName = teacher['name'];

      teacherNameWidgets.add(
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
                'ID: $teacherId',
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
                    'Name: $teacherName',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.black,
                    onPressed: () {
                      showDeleteConfirmationDialog(teacherId);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return teacherNameWidgets;
  }

  Future<void> reloadData() async {
    setState(() {}); // Trigger a rebuild of the widget tree
  }

  Future<void> deleteTeacher(String teacherId) async {
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection usersCollection = db.collection("users");
    await usersCollection.remove(mongo.where.eq('id', teacherId));

    db.close();

    // Reload the page after deleting the teacher
    await reloadData();
  }

  Future<void> showDeleteConfirmationDialog(String teacherId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Teacher'),
          content: Text('Are you sure you want to delete this teacher?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                // Delete the teacher
                await deleteTeacher(teacherId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTrPage(widget.user),
            ),
          );

          // Reload the page after returning from CreateUserPage
          await reloadData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
