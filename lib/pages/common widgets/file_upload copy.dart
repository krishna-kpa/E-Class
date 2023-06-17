import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadPage extends StatefulWidget {
  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  Dio dio = Dio();
  String _uploadResult = '';

  String? _filePath;

  Future<void> _chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _filePath = result.files.first.path;
        _uploadResult = 'File selected: $_filePath';
      });
    } else {
      // User canceled file selection
      setState(() {
        _uploadResult = 'No file selected.';
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_filePath != null) {
      try {
        String fileName = _filePath!.split('/').last;
        
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(_filePath!, filename: fileName),
        });

        Response response = await dio.post('https://e-class-file-upload.onrender.com/upload', data: formData);

        setState(() {
          _uploadResult = response.data.toString();
        });
      } catch (error) {
        setState(() {
          _uploadResult = 'Error: ${error.toString()}';
        });
      }
    } else {
      setState(() {
        _uploadResult = 'No file selected.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload'),
        backgroundColor:  const Color.fromARGB(255, 49, 30, 2),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _chooseFile,
              child: const Text('Choose File'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadFile,
              child: const Text('Upload File'),
            ),
            const SizedBox(height: 16),
            Text('Upload Result: $_uploadResult'),
          ],
        ),
      ),
    );
  }
}