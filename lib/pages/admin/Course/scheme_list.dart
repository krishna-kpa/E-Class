import 'package:flutter/material.dart';
import 'package:e_class/pages/admin/Course/scheme_add.dart';
import 'admin_semesterlist.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';

class SchemeList extends StatefulWidget {
  final scheme;
  final user;

  SchemeList(this.scheme, this.user, {Key? key});

  @override
  _SchemeListState createState() => _SchemeListState();
}

class _SchemeListState extends State<SchemeList> {
  Future<List<Widget>> showScheme() async {
    List<Widget> schemeNameWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection schemesCollection = db.collection("schemes");
    var schemes = await schemesCollection.find().toList();

    db.close();

    for (var scheme in schemes) {
      int schemeYear = scheme['name'];

      schemeNameWidgets.add(
        Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              SizedBox(
                width: 320,
                height: 100, // Increase the height value
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AdminSemesterList(schemeYear, widget.user),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 96, 49, 49),
                    ),
                    backgroundColor: const Color.fromARGB(154, 255, 240, 182),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Align text in the center vertically
                    children: [
                      Text(
                        '$schemeYear',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0, // Increase the font size
                        ),
                        textAlign: TextAlign
                            .center, // Align text at the center horizontally
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Entry'),
                        content: Text(
                            'Are you sure you want to delete this Scheme?'),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () async {
                              // Delete the entry from the database
                              var db = await mongo.Db.create(
                                  "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
                              await db.open();
                              mongo.DbCollection schemesCollection =
                                  db.collection("schemes");
                              await schemesCollection
                                  .remove(mongo.where.eq('name', schemeYear));
                              db.close();

                              // Reload the page after deleting the entry
                              await reloadData();

                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return schemeNameWidgets;
  }

  Future<void> reloadData() async {
    setState(() {}); // Trigger a rebuild of the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Scheme List', '', widget.user),
      body: Center(
        child: FutureBuilder<List<Widget>>(
          future: showScheme(),
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
              builder: (context) => CreateScheme(widget.user),
            ),
          );

          // Reload the page after returning from CreateUserPage
          await reloadData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
