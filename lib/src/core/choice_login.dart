import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_mgt/src/auth/student_auth_gate.dart';

class LoginChoicePage extends StatelessWidget {
  const LoginChoicePage({super.key});
  static const path = '/login_choice';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Choose Your Login Type"),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // context.goNamed(AppRoute.adminLogin.name);
            },
            child: const Text('Admin Login'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // context.goNamed(AppRoute.teacherLogin.name);
            },
            child: const Text('Teacher Login'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.goNamed(StudentAuthGate.path);
            },
            child: const Text('Student Login'),
          ),
        ],
      ),
    );
  }
}
