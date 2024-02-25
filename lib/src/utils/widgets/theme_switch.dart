import 'package:flutter/material.dart';
import '../settings/settings_controller.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key, required this.controller});
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      // Glue the SettingsController to the theme selection DropdownButton.
      //
      // When a user selects a theme from the dropdown list, the
      // SettingsController is updated, which rebuilds the MaterialApp.
      child: DropdownButton<ThemeMode>(
        // Read the selected themeMode from the controller
        value: controller.themeMode,
        // Call the updateThemeMode method any time the user selects a theme.
        onChanged: controller.updateThemeMode,
        items: const [
          DropdownMenuItem(
            value: ThemeMode.system,
            child: Text('System Theme'),
          ),
          DropdownMenuItem(
            value: ThemeMode.light,
            child: Text('Light Theme'),
          ),
          DropdownMenuItem(
            value: ThemeMode.dark,
            child: Text('Dark Theme'),
          )
        ],
      ),
    );
  }
}
