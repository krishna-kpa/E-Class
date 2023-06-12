import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/single_view_button.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class SingleView extends StatelessWidget {
  SingleView(this.heading, this.subject, this.moduleNo, {super.key});
  final String heading;
  var subject;
  final int moduleNo;

  Future<List<Widget>> showContent(subject, value,moduleNo) async {
    List<Widget> availableContents = [];
    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();
    mongo.DbCollection contents;
    if (value == 'Notes') {
      contents = db.collection('notes');
    } else if (value == 'Textbooks') {
      contents = db.collection('textbooks');
    } else if (value == 'Assignments') {
      contents = db.collection('assignment');
    } else {
      contents = db.collection('chatrooms');
    }
    print(contents);
    var v = await contents.find({'subjectId': subject['_id'],'moduleNo':moduleNo}).toList();
    print(v);
    db.close();
    for (var i = 0; i < v.length; i++) {
      availableContents.add(SingleViewButton(v[i]));
    }
    return availableContents;
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(heading),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child:  Container(
              child: FutureBuilder<List<Widget>>(
                future: showContent(subject, heading,moduleNo),
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
            )
        )));
  }
}
