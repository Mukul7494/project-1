import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vidhyatri/src/shared/boxes/hive_boxes.dart';

import '../../student/model/student_model.dart';
import '../courses/model/course_model.dart';
import 'attendance_model.dart';

class AttendanceTakingScreen extends StatefulWidget {
  const AttendanceTakingScreen({super.key});

  @override
  _AttendanceTakingScreenState createState() => _AttendanceTakingScreenState();
}

class _AttendanceTakingScreenState extends State<AttendanceTakingScreen> {
  final _studentsBox = Hive.box<StudentModel>('students');
  final _coursesBox = Hive.box<CourseModel>('courses');
  final _attendanceBox = Hive.box<AttendanceModel>('attendance');

  DateTime selectedDate = DateTime.now();
  String? selectedCourse;
  Map<String, bool> attendanceMap = {};
  Box box = studentBox;

  @override
  void initState() {
    super.initState();
    // Ensure courses are loaded before initializing attendance
    _loadCourses();
  }

  void _loadCourses() {
    if (_coursesBox.isNotEmpty) {
      selectedCourse = _coursesBox.values.first.title;
      _loadStudentsForCourse();
    }
  }

  void _loadStudentsForCourse() {
    setState(() {
      attendanceMap = {};
      for (var student in _studentsBox.values) {
        if (student.course == selectedCourse) {
          attendanceMap[student.key.toString()] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Attendance'),
      ),
      body: Column(
        children: [
          // Course Dropdown
          DropdownButton<String>(
            value: selectedCourse,
            onChanged: (newValue) {
              setState(() {
                selectedCourse = newValue;
                _loadStudentsForCourse();
              });
            },
            items: _coursesBox.values.map((course) {
              return DropdownMenuItem(
                value: course.title,
                child: Text(course.title),
              );
            }).toList(),
          ),

          // Date Picker
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
            ],
          ),

          // Student List
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
                      icon: attendanceMap.containsKey(student.key.toString())
                          ? const Icon(Icons.remove_circle)
                          : const Icon(Icons.add_circle),
                      onPressed: () {
                        setState(() {
                          attendanceMap.containsKey(student.key.toString())
                              ? attendanceMap.remove(student.key.toString())
                              : attendanceMap.addEntries([
                                  MapEntry(student.key.toString(), true),
                                ]);

                          setState(() {});
                          // attendanceMap[student.key.toString()] =
                          //     !attendanceMap[student.key.toString()]!;
                        });
                      },
                    ),
                  ),
                );

                // final studentKey = attendanceMap.keys.elementAt(index);
                // final student = _studentsBox.get(studentKey)!;
                // return ListTile(
                //   title: Text(student.name),
                //   leading: Checkbox(
                //     value: attendanceMap[studentKey],
                //     onChanged: (value) {
                //       setState(() {
                //         attendanceMap[studentKey] = value!;
                //       });
                //     },
                //   ),
                // );
              },
            ),
          ),

          // Save Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final attendance = AttendanceModel(
                  course: selectedCourse!,
                  date: selectedDate,
                  presentStudentKeys: attendanceMap.entries
                      .where((entry) => entry.value == true)
                      .map((entry) => entry.key)
                      .toList(),
                );
                _attendanceBox.add(attendance);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Attendance saved successfully!')),
                );
              },
              child: const Text('Save Attendance'),
            ),
          ),
        ],
      ),
    );
  }
}
