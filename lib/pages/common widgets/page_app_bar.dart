import 'package:e_class/pages/students/student_home.dart';
import 'package:e_class/pages/teachers/teacher_home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar(this.main, this.subHeading,this.userType,this.userId ,{super.key});
  String main;
  String subHeading;
  int userType;
  String userId;
  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;

  homeRouter(usertype,context){
              if(userType==1){
                Navigator.push(
                  context,MaterialPageRoute(builder: (context){
                    return const TeacherHome("teacherId");
                  })
                );
              }else{
                 Navigator.push(
                  context,MaterialPageRoute(builder: (context){
                    return  StudentHome(userId);
                  })
                );
              }
  }

  @override
  Widget build(context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),),
      backgroundColor: const  Color.fromARGB(255, 49, 30, 2),
      leading: IconButton(
            icon: const Icon(Icons.home,color: Colors.white,),
            onPressed: () {
              homeRouter(userType,context);
            },),
      centerTitle: true,
      title: Text(main,style: const TextStyle(color: Colors.white),),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(subHeading,style:const TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
