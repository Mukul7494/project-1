import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_mgt/src/constants/routes.dart';

class LoginChoicePage extends StatelessWidget {
  const LoginChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "What Descibe You Best",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              context.push(adminAuthRoute);
            },
            child: const Text('Admin'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.push(teacherAuthRoute);
            },
            child: const Text('Teacher'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.push(studentAuthRoute);
            },
            child: const Text('Student'),
          ),
        ],
      ),
    );
  }
}
