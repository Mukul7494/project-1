import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/widgets/drawer_widget.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                context.push('/settings'), // Navigate to settings page
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Profile Screen"),
          ),
          TextButton(
            onPressed: () => _auth.signOut(),
            child: (const Text("Logout")),
          ),
        ],
      ),
    );
  }
}
