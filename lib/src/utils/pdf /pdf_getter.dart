import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class PdfDownloader extends StatefulWidget {
  const PdfDownloader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PdfDownloaderState createState() => _PdfDownloaderState();
}

class _PdfDownloaderState extends State<PdfDownloader> {
  final box = Hive.box('pdfBox');

  //to download and open pdf
  Future<void> downloadAndOpenPdf(String fileName) async {
    print('Downloading and opening PDF: $fileName');
    print(box.get(fileName));
    final fileBytes = box.get(fileName);

    final appDir = await getApplicationDocumentsDirectory();
    final filePath = '${appDir.path}/$fileName';

    final file = File(filePath);
    await file.writeAsBytes(fileBytes);

    OpenFile.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Download PDF')),
      body: Center(
        child: ListView.builder(
          itemCount: box.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(box.keyAt(index)),
                onTap: () async {
                  await downloadAndOpenPdf(box.keyAt(index).toString());
                },
              ),
            );
          },
        ),
        // child: ElevatedButton(
        //   onPressed: () async {
        //     // Replace 'example.pdf' with the actual file name stored in Hive
        //     await downloadAndOpenPdf('example.pdf');
        //   },
        //   child: const Text('Download PDF'),
        // ),
      ),
    );
  }
}
