import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:e_class/pages/common widgets/page_app_bar.dart';

class CreateSub extends StatefulWidget {
  final int schemeId;
  final int sem;
  final user;

  CreateSub(this.schemeId, this.sem, this.user);

  @override
  _CreateSubState createState() => _CreateSubState();
}

class _CreateSubState extends State<CreateSub> {
  TextEditingController nameController = TextEditingController();
  TextEditingController modController = TextEditingController();
  TextEditingController idController = TextEditingController();

  saveSubject(subjectName, noofmod, id) async {
    print("save function");
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    // Get the "users" collection
    mongo.DbCollection subjectsCollections = db.collection("subjects");
    print("gotsubjects");

    var subject = {
      'id': id,
      'schemeId': widget.schemeId,
      'subjectName': subjectName,
      'noOfModules': noofmod,
      'semester': widget.sem,
    };
    await subjectsCollections.insert(subject);
    // Close the database connection
    db.close().then((value) => Navigator.pop(context));

    // Navigate back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("Create Subject", '', widget.user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Subject Id'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Subject Name'),
            ),
            TextField(
              controller: modController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number of modules'),
            ),
            TextFormField(
              initialValue: widget.schemeId.toString(),
              readOnly: true,
              decoration: InputDecoration(labelText: 'Scheme Year'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String subjectName = nameController.text;
                int nofmod = int.tryParse(modController.text) ?? 0;
                int id = int.tryParse(idController.text) ?? 0;
                saveSubject(subjectName, nofmod, id);
              },
              child: const Text('Add Subject'),
            ),
          ],
        ),
      ),
    );
  }
}
