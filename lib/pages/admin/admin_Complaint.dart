// ignore_for_file: use_build_context_synchronously
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class Complaint extends StatefulWidget {
  var user;

  Complaint(this.user, {Key? key});

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  Future<List<Widget>> showComplaints() async {
    List<Widget> complaintWidgets = [];

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();

    mongo.DbCollection complaintCollection = db.collection("complaints");
    var complaints = await complaintCollection.find().toList();

    db.close();

    for (var complaint in complaints) {
      String id = complaint['id'];
      String date = complaint['date'];
      String issue = complaint['issue'];
      String firstThreeWords =
          issue.split(' ').take(3).join(' '); // Extract first three words

      complaintWidgets.add(
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 100.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplaintDetails(
                        id: id,
                        date: date,
                        issue: issue,
                        user: widget.user,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(154, 255, 240, 182),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ID: $id',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Date: $date',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Issue: $firstThreeWords...', // Display first three words
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0), // Add spacing between entries
          ],
        ),
      );
    }

    return complaintWidgets;
  }

  // Rest of the code...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Complaints', '', widget.user),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0), // Add space at the top
        child: Center(
          child: FutureBuilder<List<Widget>>(
            future: showComplaints(),
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
      ),
    );
  }
}

class ComplaintDetails extends StatelessWidget {
  final String id;
  final String date;
  final String issue;
  final user;
  const ComplaintDetails({
    required this.id,
    required this.date,
    required this.issue,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Complaint Details', '', user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: $id',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Issue: $issue',
              style: const TextStyle(fontSize: 16.0),
            ),
            // Add any other additional details or widgets here
          ],
        ),
      ),
    );
  }
}
