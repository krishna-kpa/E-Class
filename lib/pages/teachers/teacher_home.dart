import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';


class TeacherHome extends StatelessWidget{
  const  TeacherHome(this.teacherId,{super.key});
  final String teacherId;
  @override

  Widget build(context){


    return Scaffold(appBar: CommonAppBar('E Class',teacherId,2,teacherId),);
  }

}