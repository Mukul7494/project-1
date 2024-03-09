import 'package:flutter/material.dart';
import 'package:student_mgt/src/widgets/drawer_navigation_rail.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Pannel')),
      drawer: const DrawerNavRail(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Admin,",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Explore the new features & Enjoy",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
