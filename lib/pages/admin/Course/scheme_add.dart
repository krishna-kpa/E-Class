import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:e_class/pages/common widgets/page_app_bar.dart';

class CreateScheme extends StatefulWidget {
  final user;
  CreateScheme(this.user, {Key? key});

  @override
  _CreateSchemeState createState() => _CreateSchemeState();
}

class _CreateSchemeState extends State<CreateScheme> {
  TextEditingController schemeyearController = TextEditingController();

  Future<void> saveScheme(int name) async {
    // Create a new MongoDB connection
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    // Get the "schemes" collection
    mongo.DbCollection schemesCollection = db.collection("schemes");

    // Check if the scheme already exists in the collection using the unique value "name"
    var existingScheme =
        await schemesCollection.findOne(mongo.where.eq('name', name));
    if (existingScheme != null) {
      // Scheme already exists
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Scheme with name $name already exists.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Insert the scheme document into the collection with the name as an integer
      await schemesCollection.insertOne({"name": name});

      // Close the database connection
      await db.close();

      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("Add Scheme", '', widget.user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: schemeyearController,
              keyboardType:
                  TextInputType.number, // Set the input type to number
              decoration: const InputDecoration(labelText: 'Scheme Name'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int name = int.tryParse(schemeyearController.text) ??
                    0; // Convert input to an integer or default to 0 if invalid
                saveScheme(name);
              },
              child: const Text('Add Scheme'),
            ),
          ],
        ),
      ),
    );
  }
}
