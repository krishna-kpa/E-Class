import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:e_class/pages/common widgets//schemes_button.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// ignore: must_be_immutable
class Classrooms extends StatelessWidget{
  Classrooms(this.user,{super.key});

  var user;
  

  Future<List<Widget>> showSchemes(userId,userType) async {
      List<Widget> availableScheme=[];
      var db = await mongo.Db.create("mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
      await db.open();
      mongo.DbCollection schemes;
      schemes = db.collection("schemes");
      print(schemes);
      var v = await schemes.find().toList();
      print(v);
      db.close();
      for(var i=0;i<v.length;i++){
        availableScheme.add(SchemeButton(v[i], user));
      }
      return availableScheme;
  }

  @override
  Widget build(context){
    return  Scaffold(
      appBar: CommonAppBar('Schemes', ' ', user),
      body: Center(
          child: FutureBuilder<List<Widget>>(
            future: showSchemes(user["id"],user['type']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return snapshot.data![index];
                  },
                );
              } else {
                return const Text('No data');
              }
            },
          ),
        ),
    );
  }
}