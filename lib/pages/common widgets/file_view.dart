import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('PDF Viewer'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchPDFURL(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error fetching PDF URL: ${snapshot.error}');
                
              } else if (snapshot.hasData) {
                final pdfURL = snapshot.data!;
                return PDFViewerFromURL(pdfURL: pdfURL);
              } else {
                return Text('No PDF URL found');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> fetchPDFURL() async {
    final db = await mongo.Db.create('mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority');
    await db.open();

    final collection = db.collection('notes');
    final document = await collection.findOne({'_id':'6487400fad25cb0d7f62769e'});
    final pdfURL = document?['noteLink'];
    print(pdfURL.toString());

    await db.close();

    return pdfURL ?? '';
  }
}

class PDFViewerFromURL extends StatefulWidget {
  final String pdfURL;

  PDFViewerFromURL({required this.pdfURL});

  @override
  _PDFViewerFromURLState createState() => _PDFViewerFromURLState();
}

class _PDFViewerFromURLState extends State<PDFViewerFromURL> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PDFView(
          filePath: widget.pdfURL,
          onViewCreated: (PDFViewController controller) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
