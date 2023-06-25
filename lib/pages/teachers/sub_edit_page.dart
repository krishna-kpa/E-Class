import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class SubEditPage extends StatefulWidget {
  var user;
  String initialValue;

  SubEditPage(this.user, {required this.initialValue, Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _SubEditPageState createState() => _SubEditPageState();
}

class _SubEditPageState extends State<SubEditPage> {
  String? selectedBatch;
  String? updatedBatch;

  Future<List<DropdownMenuItem<String>>> showBatchNames(
      String? initialValue) async {
    List<DropdownMenuItem<String>> batchNameWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection batchesCollection = db.collection("batches");
    var batches = await batchesCollection.find().toList();

    db.close();

    for (var batch in batches) {
      String batchYear = batch['batchYear'];

      batchNameWidgets.add(
        DropdownMenuItem(
          value: batchYear,
          child: Text(
            batchYear,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      );
    }

    if (initialValue != null &&
        !batchNameWidgets.any((item) => item.value == initialValue)) {
      batchNameWidgets.add(
        DropdownMenuItem(
          value: initialValue,
          child: Text(
            initialValue,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      );
    }

    return batchNameWidgets;
  }

  void updateData() async {
    if (updatedBatch != null && updatedBatch != selectedBatch) {
      var db = await mongo.Db.create(
          "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
      await db.open();

      mongo.DbCollection subjectCreatedCollection =
          db.collection("subjects_created");
      await subjectCreatedCollection.update(
        {"assignedBatchId": widget.initialValue},
        {
          "\$set": {"assignedBatchId": updatedBatch}
        },
      );
      db.close();
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data updated successfully!')));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Changes'),
            content: const Text('Please select a different batch.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    selectedBatch = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Create New Classroom', '', widget.user),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              FutureBuilder<List<DropdownMenuItem<String>>>(
                future: showBatchNames(selectedBatch),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return DropdownButton<String>(
                      value: updatedBatch ?? selectedBatch,
                      items: snapshot.data,
                      onChanged: (String? value) {
                        setState(() {
                          updatedBatch = value;
                        });
                      },
                      padding: const EdgeInsets.only(left: 20.0),
                      hint: const Text('Assigned Batch'),
                      isExpanded: true,
                      itemHeight: null,
                    );
                  } else {
                    return const Text('No data');
                  }
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: updateData,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
