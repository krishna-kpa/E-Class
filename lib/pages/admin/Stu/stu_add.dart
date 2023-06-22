// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:e_class/pages/common widgets/page_app_bar.dart';

class CreateStudent extends StatefulWidget {
  final user;
  CreateStudent(this.user);
  @override
  _CreateStudentState createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController batchIdController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("Add Student", '', widget.user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Admission Number'),
            ),
            TextField(
              controller: mailController,
              decoration: const InputDecoration(labelText: 'Mail Id'),
            ),
            TextField(
              controller: batchIdController,
              decoration: const InputDecoration(labelText: 'Batch ID'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Retrieve the entered data from the text fields
                String name = nameController.text;
                String mail = mailController.text;
                String id = idController.text;
                String batchId = batchIdController.text;

                // Create a new MongoDB connection
                var db = await mongo.Db.create(
                    "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
                await db.open();

                // Get the "users" collection
                mongo.DbCollection usersCollection = db.collection("users");

                // Check if the user already exists in the collection based on the admission number
                var existingUser =
                    await usersCollection.findOne(mongo.where.eq('id', id));
                if (existingUser != null) {
                  // User already exists
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(
                            'User with admission number $id already exists.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Create a new user document
                  var user = {
                    'name': name,
                    'mail': mail,
                    'id': id,
                    'password': id,
                    'batchId': batchId,
                    'type': 2,
                    // Add any other fields as needed
                  };

                  // Insert the user document into the collection
                  await usersCollection.insert(user);

                  // Close the database connection
                  db.close();

                  // Navigate back to the previous screen
                  Navigator.pop(context);
                }
              },
              child: const Text('Create Student'),
            ),
          ],
        ),
      ),
    );
  }
}
