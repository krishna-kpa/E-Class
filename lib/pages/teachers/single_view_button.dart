import 'package:e_class/pages/teachers/file_view.dart';
//import 'package:e_class/pages/teachers/assignment_page.dart';
import 'package:flutter/material.dart';

class SingleViewButton extends StatelessWidget {
  final Map<String, dynamic> content;
  final String value;
  final dynamic user;

  const SingleViewButton(this.content, this.value, this.user, {Key? key})
      : super(key: key);

  void pageRouter(BuildContext context, Map<String, dynamic> content,
      String type, dynamic user) {
    if (type.toLowerCase() == 'assignments') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Text("Assignment")), // create assignment upload and view page
      );
    } else {
      print(content);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FileViewPage(content['id'].toString(), user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => pageRouter(context, content, value, user),
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
            child: Text(
              content['name'].toString(),
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
