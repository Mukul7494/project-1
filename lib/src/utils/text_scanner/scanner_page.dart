import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class TextScannerPage extends StatefulWidget {
  const TextScannerPage({super.key});

  @override
  State<TextScannerPage> createState() => _TextScannerPageState();
}

class _TextScannerPageState extends State<TextScannerPage> {
  String text = '';
  File? image;
  ImagePicker picker = ImagePicker();

  pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<String?> getTextFromImage(File image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFile(image);
    final RecognizedText recognisedText =
        await textRecognizer.processImage(inputImage);
    String? text = recognisedText.text;
    textRecognizer.close();

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (image != null) ...[
              Image.file(image!),
              FutureBuilder(
                future: getTextFromImage(image!),
                initialData: null,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List list = [];
                  List<List> lists = [];
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          text = snapshot.data ?? '';
                          text.split('\n').forEach((element) {
                            element.split(' ').forEach((ele) {
                              list.add(ele);
                            });

                            list.add(element);

                            lists.add(list);
                          });

                          // final studentBox = Boxes.getStudents();

                          // for (var element in lists) {
                          //   studentBox.add(StudentModel(
                          //     name: element[0],
                          //     roll: 1,
                          //   ));
                          // }

                          // // print(studentBox.length);

                          // print(lists);
                          // setState(() {});
                        },
                        child: const Text('Scan Text'),
                      ),
                      Text(
                        text,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  );
                },
              ),
            ] else ...[
              ElevatedButton(
                onPressed: pickImageFromGallery,
                child: const Text('Pick Image from Gallery'),
              ),
              ElevatedButton(
                onPressed: pickImageFromCamera,
                child: const Text('Pick Image from Camera'),
              )
            ],
          ],
        ),
      ),
    );
  }
}
