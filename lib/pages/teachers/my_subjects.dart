import 'package:e_class/pages/teachers/t_subject.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:e_class/pages/teachers/sub_edit_page.dart';

class TSubjectButton extends StatelessWidget {
  final dynamic user;
  final dynamic subject;

  const TSubjectButton(this.user, this.subject, {Key? key}) : super(key: key);

  void subjectRouter(BuildContext context, dynamic subject, dynamic user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TSubject(subject, user),
      ),
    );
  }

  Future<String> findSubjectName(dynamic subject) async {
    final db = await mongo.Db.create(
      "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority",
    );
    await db.open();
    final subjects = db.collection("subjects");
    final v = await subjects.findOne({'_id': subject['detailsId']});
    db.close();
    return v!['subjectName'] +
        " \n Batch: " +
        subject['assignedBatchId'].toString();
  }

  void editSubject(BuildContext context, dynamic subject, dynamic user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SubEditPage(user, initialValue: subject['assignedBatchId']),
      ),
    );
  }

  void deleteSubject(BuildContext context, dynamic subject) async {
    final db = await mongo.Db.create(
      "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority",
    );
    await db.open();
    final subjects = db.collection("subjects_created");
    await subjects.remove({'_id': subject['_id']});
    db.close();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Subject deleted successfully.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => subjectRouter(context, subject, user),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 96, 49, 49),
                  ),
                  backgroundColor: const Color.fromARGB(154, 255, 240, 182),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: const Size(double.infinity, 80),
                ),
                child: FutureBuilder<String>(
                  future: findSubjectName(subject),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        snapshot.data ?? 'No data',
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: () => editSubject(context, subject, user),
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => deleteSubject(context, subject),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
