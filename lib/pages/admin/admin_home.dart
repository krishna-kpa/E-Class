import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets/page_app_bar.dart';

class Navbutton extends StatelessWidget {
  final String name;
  final ImageProvider image;
  final VoidCallback onPressed;

  Navbutton({required this.name, required this.image, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 180.0,
      margin: EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: const Color.fromARGB(255, 214, 186, 175),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: image, width: 60.0, height: 60.0),
            SizedBox(height: 16.0),
            Text(
              name,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class complaintbut extends StatelessWidget {
  final String name;
  final ImageProvider image;
  final VoidCallback onPressed;

  complaintbut(
      {required this.name, required this.image, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0,
      margin: EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: const Color.fromARGB(255, 214, 186, 175),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: image, width: 40.0, height: 40.0),
            SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminHome extends StatelessWidget {
  dynamic user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("My Classroom", "", user),
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
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Navbutton(
                  name: 'Batches',
                  image: AssetImage('assets/images/batch.png'),
                  onPressed: () {
                    // Action for button 2
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
                  image: AssetImage('assets/images/course.png'),
                  onPressed: () {
                    // Action for button 3
                  },
                ),
              ),
              Expanded(
                child: Navbutton(
                  name: 'Students',
                  image: AssetImage('assets/images/student.png'),
                  onPressed: () {
                    // Action for button 4
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 90.0),
          Align(
            alignment: Alignment.bottomCenter,
            child: complaintbut(
              name: 'Complaints',
              image: AssetImage('assets/images/report.png'),
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
