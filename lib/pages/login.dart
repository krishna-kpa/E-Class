import 'package:e_class/pages/admin/admin_home.dart';
import 'package:e_class/pages/students/student_home.dart';
import 'package:e_class/pages/teachers/teacher_home.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var invalidCredential = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();
  bool passenable = true;

  Future<void> validateAndSave(context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      var db = await mongo.Db.create(
          "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
      await db.open();
      mongo.DbCollection users;
      users = db.collection("users");
      print(users);
      print(userName.text);
      var v =
          await users.findOne({"id": userName.text, "password": password.text});
      db.close();
      print(v);
      if (v == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else if (v['type'] == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StudentHome(v),
          ),
        );
      } else if (v["type"] == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TeacherHome(v),
          ),
        );
      } else if (v["type"] == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHome(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/logo.png",
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userName,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(150, 255, 255, 255),
                          border: const OutlineInputBorder(),
                          hintText: 'userid',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 51, 36, 0)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your user id';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: TextFormField(
                        controller: password,
                        obscureText: passenable,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffix: Align(
                            heightFactor: .5,
                            widthFactor: .2,
                            child: IconButton(
                                onPressed: () => setState(() {
                                      //refresh UI
                                      if (passenable) {
                                        //if passenable == true, make it false
                                        passenable = false;
                                      } else {
                                        passenable =
                                            true; //if passenable == false, make it true
                                      }
                                    }),
                                icon: Icon(passenable == true
                                    ? Icons.remove_red_eye
                                    : Icons.password)),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(150, 255, 255, 255),
                          border: const OutlineInputBorder(),
                          hintText: 'password',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 51, 36, 0)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'min 6 characters';
                          } else if (invalidCredential.isNotEmpty) {
                            return invalidCredential;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            backgroundColor:
                                const Color.fromARGB(213, 255, 248, 236)),
                        onPressed: () {
                          validateAndSave(context);
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
