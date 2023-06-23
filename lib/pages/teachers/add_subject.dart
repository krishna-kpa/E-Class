import 'package:flutter/material.dart';

class AddSubject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
      ),
      body: const Center(
        child: Text('This is a new page.'),
      ),
    );
  }
}
