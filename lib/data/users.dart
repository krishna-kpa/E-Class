import 'package:e_class/models/students.dart';
import 'package:e_class/models/teachers.dart';

/*
 String admissionNo;
  String name;
  String mail;
  String password;
  int batchId;
*/

var students = [
  Students('20BR13466','Krishna Prasad A','20br13466@rit.ac.in','101010',2019),
  Students('20BR13467','Krishna','20br13467@rit.ac.in','101011',2019),
  Students('20BR13468','Prasad','20br13486@rit.ac.in','101012',2019),
];

var teachers = [
  Teacher( "AK101","AnilKumar", "anilkumar@rit", "passWord1",   [1,5,10,15,19,24]),
  Teacher("teacherCode2","teacher2", "ritMail2", "passWord2", [2,6,11,16,20,25]),
  Teacher("teacherCode3","teacher3", "ritMail3", "passWord3", [3,7,12,17,21,26]),
  Teacher("teacherCode4","teacher4", "ritMail4", "passWord4", [4,8,13,18,22,27]),
  Teacher( "teacherCode5","teacher5", "ritMail5", "passWord5", [9,14,23,28]),
  Teacher("teacherCode6","teacher6", "ritMail6", "passWord6", [29]),
  Teacher("teacherCode7","teacher4", "ritMail4", "passWord4", [30]),
  Teacher( "teacherCode8","teacher5", "ritMail5", "passWord5", [31]),
  Teacher( "teacherCode9","teacher6", "ritMail6", "passWord6", [32]),
];

final admin = {
  "password":"1234567"
};