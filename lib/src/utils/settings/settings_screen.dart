import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
  ThemeMode _currentThemeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _currentThemeMode = ref.read(themeModeProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
              Icons.arrow_back_outlined), // Adjust color for contrast
        ),
        // Set app bar color based on theme
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Add some padding for visual appeal
        child: Column(
          children: [
            DropdownButton<ThemeMode>(
              value: _currentThemeMode,
              items: ThemeMode.values.map((ThemeMode mode) {
                return DropdownMenuItem<ThemeMode>(
                  value: mode,
                  child: Text(mode == ThemeMode.system ? 'System' : mode.name),
                );
              }).toList(),
              onChanged: (ThemeMode? newMode) {
                setState(() {
                  _currentThemeMode = newMode!;
                  ref.read(themeModeProvider.notifier).state = newMode;
                });
              },

              underline: Container(
                decoration: const BoxDecoration(color: Colors.white),
              ), // Remove default underline
              style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white), // Adjust font size for readability
            ),
          ],
        ),
      ),
    );
  }
}
