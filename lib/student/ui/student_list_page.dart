import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_mgt/boxes/hive_boxes.dart';
import 'package:student_mgt/student/model/student_model.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  Box box = studentBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final StudentModel student = box.getAt(index);
                  return Card(
                    child: ListTile(
                      title: Text(student.name),
                      subtitle: Text(student.roll.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            box.delete(student.name);
                          });
                        },
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
