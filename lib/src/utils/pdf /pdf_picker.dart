import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:typed_data';

class PdfUploader extends StatefulWidget {
  const PdfUploader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PdfUploaderState createState() => _PdfUploaderState();
}

class _PdfUploaderState extends State<PdfUploader> {
  Future<void> pickAndUploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], withData: true);

    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      final fileName = result.files.first.name;
      final box = Hive.box('pdfBox');
      box.put(fileName, fileBytes);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('PDF Uploaded: $fileName')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload PDF')),
      body: Center(
        child: ElevatedButton(
          onPressed: pickAndUploadPdf,
          child: const Text('Upload PDF'),
        ),
      ),
    );
  }
}
