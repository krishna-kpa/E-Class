import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TeacherMyClassroom extends StatelessWidget{
  TeacherMyClassroom(this.user,{super.key});
  var user;

  @override
  Widget build(context){
    return  Scaffold(body: Text(user.toString()),);
  }
}