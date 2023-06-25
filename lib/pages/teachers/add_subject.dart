import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class AddSubject extends StatefulWidget {
  var user;

  AddSubject(this.user, {Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  String? selectedBatch;
  int? selectedValue;
  String? selectedSubject;
  int? selectedSemester;

  Future<List<DropdownMenuItem<String>>> showBatchNames() async {
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

    return batchNameWidgets;
  }

  Future<List<DropdownMenuItem<String>>> showSubjectNames() async {
    List<DropdownMenuItem<String>> subjectNameWidgets = [];

    if (selectedSemester == null) {
      return subjectNameWidgets;
    }

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection subjectsCollection = db.collection("subjects");
    var subjects = await subjectsCollection
        .find(
          mongo.where.eq("semester", selectedSemester),
        )
        .toList();

    db.close();

    for (var subject in subjects) {
      String subjectName = subject['subjectName'];

      subjectNameWidgets.add(
        DropdownMenuItem(
          value: subjectName,
          child: Text(
            subjectName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      );
    }

    return subjectNameWidgets;
  }

  List<DropdownMenuItem<int>> generateDropdownItems() {
    return List<DropdownMenuItem<int>>.generate(
      8,
      (index) => DropdownMenuItem<int>(
        value: index + 1,
        child: Text(
          (index + 1).toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  void submitData() async {
    if (selectedBatch != null &&
        selectedSemester != null &&
        selectedSubject != null) {
      var db = await mongo.Db.create(
          "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
      await db.open();

      mongo.DbCollection subjectCreatedCollection =
          db.collection("subjects_created");
      var subject = await db.collection("subjects").findOne(
            mongo.where.eq("subjectName", selectedSubject),
          );

      if (subject != null && subject['id'] != null) {
        await subjectCreatedCollection.insert({
          "id": subject['id'],
          "detailsId": subject['_id'],
          "assignedBatchId": selectedBatch,
          "teacherId": widget.user != null ? widget.user['id'] : null,
        });

        db.close();

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Classroom created successfully!')));

        // Navigate to previous page
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Subject not found')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select all fields')));
    }
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
                future: showBatchNames(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return DropdownButton<String>(
                      value: selectedBatch,
                      items: snapshot.data,
                      onChanged: (String? value) {
                        setState(() {
                          selectedBatch = value;
                          selectedSubject = null;
                          selectedSemester = null;
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
              DropdownButton<int>(
                value: selectedValue,
                items: generateDropdownItems(),
                onChanged: (int? value) {
                  setState(() {
                    selectedValue = value;
                    selectedSemester = value!;
                    selectedSubject = null;
                  });
                },
                padding: const EdgeInsets.only(left: 20.0),
                hint: const Text('Semester'),
                isExpanded: true,
                itemHeight: null,
              ),
              const SizedBox(height: 20.0),
              FutureBuilder<List<DropdownMenuItem<String>>>(
                future: showSubjectNames(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return DropdownButton<String>(
                      value: selectedSubject,
                      items: snapshot.data,
                      onChanged: (String? value) {
                        setState(() {
                          selectedSubject = value;
                        });
                      },
                      padding: const EdgeInsets.only(left: 20.0),
                      hint: const Text('Subjects'),
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
                onPressed: submitData,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
