import 'package:flutter/material.dart';
import '../utils/widgets/drawer_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const path = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student App')),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/flutter_logo.png'),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
