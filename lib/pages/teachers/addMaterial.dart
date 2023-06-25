import 'package:e_class/pages/common%20widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class FileUploadPage extends StatefulWidget {
  FileUploadPage(this.user, this.heading, this.moduleNo, this.subject,
      {Key? key})
      : super(key: key);

  final String heading;
  final int moduleNo;
  final dynamic user;
  final dynamic subject;

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  Dio dio = Dio();
  String _uploadResult = '';
  String? _filePath;
  int? _noteNo;
  String? _name;
  bool _isLoading = false;

  Future<void> _chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _filePath = result.files.first.path!;
        _uploadResult = 'File selected: $_filePath';
      });

      await _showInputDialog();
    } else {
      // User canceled file selection
      setState(() {
        _uploadResult = 'No file selected.';
      });
    }
  }

  Future<void> _showInputDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Note Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Note Number'),
                onChanged: (value) {
                  setState(() {
                    _noteNo = int.tryParse(value);
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _uploadFile();
              },
              child: const Text('Upload'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadFile() async {
    if (_filePath != null && _noteNo != null && _name != null) {
      try {
        setState(() {
          _isLoading = true;
        });

        String fileName = _filePath!.split('/').last;

        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(_filePath!, filename: fileName),
        });

        Response response = await dio.post(
          'https://e-class-file-upload.onrender.com/upload',
          data: formData,
        );

        String fileId = response.data.toString();

        // Store the file ID in the MongoDB document
        await _storeFileId(fileId,widget.heading);

        setState(() {
          _isLoading = false;
          _uploadResult = 'File uploaded successfully. ID: $fileId';
        });

        // Navigate back to the previous page
        Navigator.pop(context, true); // Pass a value to indicate success
      } catch (error) {
        setState(() {
          _isLoading = false;
          _uploadResult = 'Error: ${error.toString()}';
        });
      }
    } else {
      setState(() {
        _uploadResult = 'No file selected.';
      });
    }
  }

  Future<void> _storeFileId(String fileId,type) async {
    var db = await mongo.Db.create(
        'mongodb+srv://admin_kp:admin123@cluster0.hlr4lt7.mongodb.net/e-class?retryWrites=true&w=majority');
    await db.open();

    var collection = db.collection('notes');

    var document = {
      'subjectId': widget.subject['_id'],
      'moduleNo': widget.moduleNo,
      'noteNo': _noteNo,
      'name': _name,
      'id': fileId,
    };

    await collection.insertOne(document);

    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('FileUpload', '', widget.user),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _chooseFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(154, 255, 240, 182),
                        ),
                        child: const Text(
                          'Choose File',
                          style: TextStyle(
                              color: Color.fromARGB(255, 96, 49, 49)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Upload Result: $_uploadResult',
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
    );
  }
}
