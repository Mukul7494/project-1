import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_mgt/src/core/choice_login.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
static const path = '/splash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Splash Page"),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed(LoginChoicePage.path);
            },
            child: const Text('Go To Login'),
          ),
        ],
      ),
    );
  }
}
