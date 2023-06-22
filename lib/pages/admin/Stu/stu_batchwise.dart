import 'package:e_class/pages/admin/Stu/stu_list.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class StuBatchList extends StatefulWidget {
  final batch;
  final user;

  const StuBatchList(this.batch, this.user, {Key? key});

  @override
  _StuBatchListState createState() => _StuBatchListState();
}

class _StuBatchListState extends State<StuBatchList> {
  Future<List<Widget>> showBatchNames() async {
    List<Widget> batchNameWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection batchesCollection = db.collection("batches");
    var batches = await batchesCollection.find().toList();

    db.close();

    for (var Batch in batches) {
      String batchyear = Batch['batchYear'];

      batchNameWidgets.add(Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: 150,
          height: 100,
          child: ElevatedButton(
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
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentList(batchyear, widget.user),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$batchyear',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ));
    }

    return batchNameWidgets;
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
    );
  }
}
