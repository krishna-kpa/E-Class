// ignore_for_file: library_private_types_in_public_api
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ReportScreen extends StatefulWidget {
  final user;

  ReportScreen(this.user);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController _textEditingController = TextEditingController();
  final String _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String userId = '';

  Future<void> _submitData() async {
    String issue = _textEditingController.text;
    print('Entered text: $issue');
    print('Current Date: $_currentDate');

    var db = await mongo.Db.create(
        "mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority");
    await db.open();
    mongo.DbCollection complaintCollection = db.collection("complaints");
    var complaint = {
      'id': userId.toString(),
      'date': _currentDate.toString(),
      'issue': issue.toString(),
    };
    print("document created");
    await complaintCollection
        .insertOne(complaint);
    db.close();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Report Sent')));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    userId = widget.user['id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar("Report Issue", '', widget.user),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.grey[200], // Set desired background color
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: userId,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Issue',
                      contentPadding: EdgeInsets.all(16.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
