import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:e_class/pages/common widgets/page_app_bar.dart';

class CreateBatch extends StatefulWidget {
  final user;
  CreateBatch(this.user);
  @override
  _CreateBatchState createState() => _CreateBatchState();
}

class _CreateBatchState extends State<CreateBatch> {
  TextEditingController batchYearController = TextEditingController();

  Future<void> saveBatch(String batchYear) async {
    // Create a new MongoDB connection
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    // Get the "batches" collection
    mongo.DbCollection batchesCollection = db.collection("batches");

    // Check if the batch already exists in the collection using the unique value "batchYear"
    var existingBatch =
        await batchesCollection.findOne(mongo.where.eq('batchYear', batchYear));
    if (existingBatch != null) {
      // Batch already exists
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Batch with year $batchYear already exists.'),
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
      // Insert the batch document into the collection
      await batchesCollection.insertOne({"batchYear": batchYear});

      // Close the database connection
      db.close().then((value) => Navigator.pop(context));

      // Navigate back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Add Batch', '', widget.user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: batchYearController,
              decoration: InputDecoration(labelText: 'Batch Year'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                saveBatch(batchYearController.text);
              },
              child: const Text('Create Batch'),
            ),
          ],
        ),
      ),
    );
  }
}
