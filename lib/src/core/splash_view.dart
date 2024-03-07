import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_mgt/src/constants/routes.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

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
              context.namedLocation(loginChoiceRoute);
            },
            child: const Text('Go To Login'),
          ),
        ],
      ),
    );
  }
}
