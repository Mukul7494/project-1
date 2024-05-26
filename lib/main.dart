import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vidhyatri/src/features/attendance/attendance_model.dart';
import 'package:vidhyatri/src/features/courses/model/course_model.dart';
import 'package:vidhyatri/src/shared/boxes/hive_boxes.dart';
import 'src/firebase_options.dart';
import 'src/app.dart';
import 'src/shared/theme/controllers/theme_controller.dart';
import 'src/shared/theme/services/theme_service.dart';
import 'src/shared/theme/services/theme_service_hive.dart';
import 'src/student/model/student_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // The ThemeServiceHive constructor requires a box name, the others do not.
  // The box name is just a file name for the file that stores the settings.
  final ThemeService themeService = ThemeServiceHive(
    'flex_color_scheme_v5_box_5',
  );
  // Initialize the theme service.
  await themeService.init();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  // await Hive.initFlutter();

  Hive.registerAdapter(StudentModelAdapter());
  Hive.registerAdapter(CourseModelAdapter());
  Hive.registerAdapter(AttendanceModelAdapter());

  //for opening the student box
  studentBox = await Hive.openBox<StudentModel>("Students");
  courseBox = await Hive.openBox<CourseModel>("Courses");
  await Hive.openBox<AttendanceModel>('attendance');
  await Hive.openBox('pdfBox');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // GoogleProvider(
    //     clientId:
    //     "YOURCLIENTID")
  ]);
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // Create a ThemeController that uses the ThemeService.
  final ThemeController themeController = ThemeController(themeService);
  // Load preferred theme settings, while the app is loading, before MaterialApp
  // is created, this prevents a theme change when the app is first displayed.
  await themeController.loadAll();
  // Run the app and pass in the ThemeController. The app listens to the
  // ThemeController for changes. The same ThemeController as used in example 4
  // controls all the myriad of Theme settings and the ThemeService also
  // persists the settings with the injected ThemeServiceHive.
  runApp(Builder(builder: (context) {
    return UncontrolledProviderScope(
        container: ProviderContainer(),
        child: MyApp(controller: themeController));
  }));
}
