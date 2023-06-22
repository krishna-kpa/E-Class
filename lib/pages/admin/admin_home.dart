import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/page_app_bar.dart';
import 'Teacher/tr_list.dart';
import 'batch/list_batch.dart';
import 'Course/scheme_list.dart';
import 'Stu/stu_batchwise.dart';

class Navbutton extends StatelessWidget {
  final String name;
  final ImageProvider image;
  final VoidCallback onPressed;

  // ignore: use_key_in_widget_constructors
  const Navbutton(
      {required this.name, required this.image, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 180.0,
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: const Color.fromARGB(255, 214, 186, 175),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: image, width: 60.0, height: 60.0),
            const SizedBox(height: 16.0),
            Text(
              name,
              style: const TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class complaintbut extends StatelessWidget {
  final String name;
  final ImageProvider image;
  final VoidCallback onPressed;

  const complaintbut(
      {super.key,
      required this.name,
      required this.image,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0,
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: const Color.fromARGB(255, 214, 186, 175),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: image, width: 40.0, height: 40.0),
            const SizedBox(width: 8.0),
            Text(
              name,
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AdminHome extends StatelessWidget {
  dynamic user;

  AdminHome({this.user, super.key});

  get batch => null;

  get scheme => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("E class", "Admin", user),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Navbutton(
                  name: 'Teacher',
                  image: const AssetImage('assets/images/teacher.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TeacherList(user)),
                    );
                  },
                ),
              ),
              Expanded(
                child: Navbutton(
                  name: 'Batches',
                  image: const AssetImage('assets/images/batch.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BatchList(batch, user)),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Navbutton(
                  name: 'Courses',
                  image: const AssetImage('assets/images/course.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SchemeList(scheme, user)),
                    );
                  },
                ),
              ),
              Expanded(
                child: Navbutton(
                  name: 'Students',
                  image: const AssetImage('assets/images/student.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StuBatchList(batch, user)),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 90.0),
          Align(
            alignment: Alignment.bottomCenter,
            child: complaintbut(
              name: 'Complaints',
              image: const AssetImage('assets/images/report.png'),
              onPressed: () {
                // Action for rectangle button
              },
            ),
          ),
        ],
      ),
    );
  }
}
