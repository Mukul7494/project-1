import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';

class TeacherDrawerWidget extends StatelessWidget {
  const TeacherDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 130,
              color: const Color.fromARGB(138, 227, 212, 109),
              child: const Padding(
                padding: EdgeInsets.all(30),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/teacherd.png'),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dr.Mohit', style: TextStyle(fontSize: 16)),
                        Text('amit@ace.edu', style: TextStyle(fontSize: 14)),
                        Text('B.Tech/CSE/A1', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const Divider(color: Colors.black),
                  const ListTile(
                    title: Text("Features"),
                    textColor: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text("Add Student"),
                    onTap: () => context.push("/createStudentFormPage"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Students List"),
                    onTap: () => context.push("/studentListPage"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.chrome_reader_mode_outlined),
                    title: const Text("Create Courses"),
                    onTap: () => context.push("/createCourses"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.chrome_reader_mode_outlined),
                    title: const Text("courses View"),
                    onTap: () => context.push("/coursesView"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.view_list_outlined),
                    title: const Text("Take Attendance"),
                    onTap: () => context.push("/takeAttendance"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.file_upload_outlined),
                    title: const Text("Upload Notes"),
                    onTap: () => context.push("/noteshomepage"),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(color: Colors.black),
                  const ListTile(
                    title: Text("Settings"),
                    textColor: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.abc_outlined),
                    title: const Text("Languages"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.brightness_4_outlined),
                    title: const Text("Theme Prefrences"),
                    onTap: () {
                      context.go('/settings');
                    },
                  ),
                  const Divider(color: Colors.black),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text("About Us"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.post_add),
                    title: const Text("Invite Program"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.lightbulb_outline),
                    title: const Text("Smart Program"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield_outlined),
                    title: const Text("Privacy Policy"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.cookie_outlined),
                    title: const Text("Cookie policy"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: const Text("Contact"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.pageview_outlined),
                    title: const Text(" Terms And Conditions"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_mark_rounded),
                    title: const Text("Help"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentDrawerWidget extends StatelessWidget {
  const StudentDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 130,
              color: const Color.fromARGB(206, 116, 161, 240),
              child: const Padding(
                padding: EdgeInsets.all(30),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/mylogo.png'),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mohit Chauhan', style: TextStyle(fontSize: 16)),
                        Text('mohit@dev.in', style: TextStyle(fontSize: 14)),
                        Text('B.Tech/CSE/A1', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const Divider(color: Colors.black),
                  const ListTile(
                    title: Text("Features"),
                    textColor: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.chrome_reader_mode_outlined),
                    title: const Text("My Courses"),
                    onTap: () => context.push("/coursesView"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.chrome_reader_mode_outlined),
                    title: const Text("Attendance View"),
                    onTap: () => context.push("/attendance"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.quiz_outlined),
                    title: const Text("Study Material/Notes"),
                    onTap: () => context.push("/noteshomepagestd"),
                  ),
                  ListTile(
                    leading: const LineIcon(Icons.post_add),
                    title: const Text("Exam Corner"),
                    onTap: () => context.push("/exams"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.quiz_outlined),
                    title: const Text("Quizzes"),
                    onTap: () => context.push("/quiz"),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(color: Colors.black),
                  const ListTile(
                    title: Text("Settings"),
                    textColor: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.abc_outlined),
                    title: const Text("Languages"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.brightness_4_outlined),
                    title: const Text("Theme Prefrences"),
                    onTap: () {},
                  ),
                  const Divider(color: Colors.black),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text("About Us"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield_moon_outlined),
                    title: const Text("Student Protection"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.card_membership_outlined),
                    title: const Text("Payments"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield_outlined),
                    title: const Text("Privacy Policy"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.cookie_outlined),
                    title: const Text("Cookie policy"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: const Text("Contact"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.pageview_outlined),
                    title: const Text(" Terms And Conditions"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_mark_rounded),
                    title: const Text("Help"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
