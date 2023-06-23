import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class FileViewPage extends StatefulWidget {
  final String fileId;

  FileViewPage(this.fileId, user);

  @override
  _FileViewPageState createState() => _FileViewPageState();
}

class _FileViewPageState extends State<FileViewPage> {
  Dio dio = Dio();
  bool _isLoading = true;
  String _filePath = '';

  @override
  void initState() {
    super.initState();
    _fetchFile();
  }

  Future<void> _fetchFile() async {
    try {
      Response response = await dio.get(
        'https://e-class-file-upload.onrender.com/files/${widget.fileId}',
        options: Options(responseType: ResponseType.bytes),
      );
      print(response.data);
      print(response.headers);
      final appDir = await getApplicationDocumentsDirectory();
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.pdf'; // Generate a unique file name
      final filePath = '${appDir.path}/$fileName';

      await File(filePath).writeAsBytes(response.data);

      setState(() {
        _isLoading = false;
        _filePath = filePath;
        print("the path: $_filePath");
      });
    } catch (error) {
      if (error is DioError) {
        print("DioError: ${error.response?.data}");
      } else {
        print("Error: $error");
      }
      setState(() {
        _isLoading = false;
        _filePath = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File View'),
        backgroundColor: const Color.fromARGB(255, 49, 30, 2),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filePath.isNotEmpty
              ? PDFView(
                  filePath: _filePath,
                )
              : const Center(
                  child: Text('Failed to fetch file.'),
                ),
    );
  }
}
