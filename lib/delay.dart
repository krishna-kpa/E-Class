import 'package:flutter/material.dart';
import 'package:e_class/pages/login.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),)
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ],
     ),
);
}
}