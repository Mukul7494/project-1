import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_mgt/boxes/hive_boxes.dart';
import 'package:student_mgt/student/model/student_model.dart';

class CreateStudentFormPage extends StatefulWidget {
  const CreateStudentFormPage({super.key});

  @override
  State<CreateStudentFormPage> createState() => _CreateStudentFormPageState();
}

class _CreateStudentFormPageState extends State<CreateStudentFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final Box box = studentBox;

  @override
  void dispose() {
    _nameController.dispose();
    _rollNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Student Details',
              textScaler: TextScaler.linear(2),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _rollNumberController,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                box.put(
                  _nameController.text,
                  StudentModel(
                      name: _nameController.text,
                      roll: int.parse(_rollNumberController.text)),
                );
                _nameController.clear();
                _rollNumberController.clear();
              },
              child: const Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}
