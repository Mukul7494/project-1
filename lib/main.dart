import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_mgt/boxes/hive_boxes.dart';
import 'package:student_mgt/student/model/student_model.dart';
import 'src/app.dart';
import 'firebase_options.dart';
import 'src/shared/settings/settings_controller.dart';
import 'src/shared/settings/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  //for opening the student box
  studentBox = await Hive.openBox<StudentModel>("Students");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // GoogleProvider(
    //     clientId:
    //     "YOURCLIENTID"),
  ]);
  runApp(
    ProviderScope(
      child: MyApp(settingsController: settingsController),
    ),
  );
}
