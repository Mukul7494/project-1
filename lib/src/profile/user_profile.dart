import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_mgt/src/constants/routes.dart';
import '../widgets/drawer_widget.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      drawer: const DrawerWidget(),
      body: ProfileScreen(
        actions: [
          SignedOutAction((context) {
            context.pushReplacementNamed(loginChoiceRoute);
          })
        ],
        children: const [],
      ),
    );
  }
}
