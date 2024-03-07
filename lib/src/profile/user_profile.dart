import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_mgt/src/core/choice_login.dart';
import 'package:student_mgt/src/core/splash_view.dart';
import '../utils/widgets/drawer_widget.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  static const path = '/User_Profile';

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
            context.pushReplacementNamed(LoginChoicePage.path);
          })
        ],
        children: const [],
      ),
    );
  }
}
