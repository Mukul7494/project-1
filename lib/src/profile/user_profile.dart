import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  static const path = '/User_Profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(),
      body: ProfileScreen(
        appBar: AppBar(
          title: const Text('User Profile'),
        ),
        actions: [
          SignedOutAction((context) {
            Navigator.of(context).pop();
          })
        ],
      ),
    );
  }
}
