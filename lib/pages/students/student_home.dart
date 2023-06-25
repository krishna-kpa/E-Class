import 'package:e_class/pages/common%20widgets/complaints.dart';
import 'package:e_class/pages/common%20widgets/home_button.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  final user;

  StudentHome(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('E Class', user["id"], user),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeButton("Classrooms", user),
                    HomeButton("My Classroom", user),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) =>  ReportScreen(user)))
            },
            style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 96, 49, 49),
                ),
                backgroundColor: const Color.fromARGB(154, 255, 240, 182),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: const Text('Report Issue',
                style:  TextStyle(
                  color: Color.fromRGBO(118, 82, 71, 1),
                  fontSize: 18,
                )),
          )),
    )
            ],
          ),
        ),
      ),
    );
  }
}
