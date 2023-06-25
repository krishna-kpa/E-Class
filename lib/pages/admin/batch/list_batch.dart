// ignore_for_file: use_build_context_synchronously

import 'package:e_class/pages/admin/batch/batch_add.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class BatchList extends StatefulWidget {
  final batch;
  var user;

  BatchList(this.batch, this.user, {Key? key});

  @override
  _BatchListState createState() => _BatchListState();
}

class _BatchListState extends State<BatchList> {
  Future<List<Widget>> showBatchNames() async {
    List<Widget> batchNameWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection batchesCollection = db.collection("batches");
    var batches = await batchesCollection.find().toList();

    db.close();

    for (var batch in batches) {
      String batchYear = batch['batchYear'];

      batchNameWidgets.add(
        Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(154, 255, 240, 182),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.brown,
              width: 2.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '$batchYear',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  deleteBatch(batchYear);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      );
    }

    return batchNameWidgets;
  }

  Future<void> deleteBatch(String batchYear) async {
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Batch'),
          content:
              Text('Are you sure you want to delete the batch $batchYear?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await deleteBatchData(batchYear); // Delete the batch
                Navigator.pop(context); // Close the dialog
                await reloadData(); // Reload the page after deleting the batch
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    db.close();
  }

  Future<void> deleteBatchData(String batchYear) async {
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection batchesCollection = db.collection("batches");
    mongo.DbCollection usersCollection = db.collection("users");
    await usersCollection.remove(mongo.where.eq('batchId', batchYear));
    await batchesCollection.remove(mongo.where.eq('batchYear', batchYear));

    db.close();
  }

  Future<void> reloadData() async {
    setState(() {}); // Trigger a rebuild of the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Batch List', '', widget.user),
      body: Center(
        child: FutureBuilder<List<Widget>>(
          future: showBatchNames(),
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
              builder: (context) => CreateBatch(widget.user),
            ),
          );

          // Reload the page after returning from CreateBatch
          await reloadData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
