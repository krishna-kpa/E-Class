// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:e_class/pages/common widgets/page_app_bar.dart';

class CreateTrPage extends StatefulWidget {
  final user;
  CreateTrPage(this.user);
  @override
  _CreateTrPageState createState() => _CreateTrPageState();
}

class _CreateTrPageState extends State<CreateTrPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("E class", "Admin", widget.user),
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
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: mailController,
              decoration: const InputDecoration(labelText: 'Mail Id'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Retrieve the entered data from the text fields
                String name = nameController.text;
                String mail = mailController.text;
                String id = idController.text;

                // Create a new MongoDB connection
                var db = await mongo.Db.create(
                    "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
                await db.open();

                // Get the "users" collection
                mongo.DbCollection usersCollection = db.collection("users");

                // Check if the teacher already exists in the collection using the unique ID
                var existingTeacher =
                    await usersCollection.findOne(mongo.where.eq('id', id));
                if (existingTeacher != null) {
                  // Teacher already exists
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text('Teacher with ID $id already exists.'),
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
                    'id': id.toUpperCase(),
                    'password': id,
                    'type': 1,
                    // Add any other fields as needed
                  };

                  // Insert the user document into the collection
                  await usersCollection.insert(user);

                  // Close the database connection
                  db.close();

                  // Navigate back to the previous screen
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Teacher Added')));
                }
              },
              child: const Text('Create Teacher'),
            ),
          ],
        ),
      ),
    );
  }
}
