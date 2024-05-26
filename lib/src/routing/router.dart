import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vidhyatri/src/Notes/NotesHomePage.dart';
import 'package:vidhyatri/src/admin/admin_view.dart';
import 'package:vidhyatri/src/features/onboarding_view.dart';
import 'package:vidhyatri/src/features/courses/ui/courses_view.dart';
import 'package:vidhyatri/src/features/courses/ui/create_courses.dart';
import 'package:vidhyatri/src/shared/theme/controllers/theme_controller.dart';
import 'package:vidhyatri/src/teacher/teacher_home_view.dart';
import 'package:vidhyatri/src/utils/pdf%20/pdf_getter.dart';
import 'package:vidhyatri/src/utils/pdf%20/pdf_picker.dart';
import '../features/attendance/attendace_view.dart';
import '../features/attendance/take_attendance.dart';
import '../features/auth/views/admin_auth_gate.dart';
import '../features/auth/views/choice_login.dart';
import '../features/auth/views/student_auth_gate.dart';
import '../features/auth/views/teacher_auth_gate.dart';
import '../features/bottom_nav_bar.dart';
import '../shared/settings/settings_view.dart';
import '../student/profile/user_profile.dart';
import '../shared/constants/routes.dart';
import '../student/home/std_home_view.dart';
import '../student/ui/create_student_form.dart';
import '../student/ui/student_list.dart';
import '../student/ui/student_list_page.dart';
import '../teacher/class_view.dart';
import '../teacher/student_view.dart';
import '../teacher/user_profile.dart';
part 'router.g.dart';

// This is the router provider that will be used in the main.dart file
// to pass the router to the MaterialApp.router
@riverpod
GoRouter router(RouterRef ref) {
  (context, state) {
    return RouteInformation(
      location: state.location,
    );
  };
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  // final adminNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'admin');
  // final studentNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'student');
  // final teacherNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');
  final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  final courseNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'course');
  final attendanceNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'attendance');
  final profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');
  final tProfileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: onboardingRoute,
    debugLogDiagnostics: true,
    // Restoring the state of the router when the app is resumed
    restorationScopeId: 'router',

    routes: [
      GoRoute(
        path: onboardingRoute,
        builder: (context, state) => const PdfDownloader(),
        // builder: (context, state) => StdHomeViewO(),
        name: onboardingRoute,
      ),

      ///--------------------------------------------Auth---------------------------------------------------------///

      GoRoute(
        path: loginChoiceRoute,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginChoicePage(),
        ),
        name: loginChoiceRoute,
      ),

      /// Define routes based on user role
      GoRoute(
        path: adminAuthRoute,
        builder: (context, state) {
          return const AdminAuthGate();
        },
        name: adminAuthRoute,
      ),
      GoRoute(
        path: teacherAuthRoute,
        builder: (context, state) {
          return const TeacherAuthGate();
        },
        name: teacherAuthRoute,
      ),
      GoRoute(
        path: studentAuthRoute,
        builder: (context, state) {
          return const StudentAuthGate();
        },
        name: studentAuthRoute,
      ),

      ///-----------Student--------------------BottomNavBar---------------------------------------------------///

      StatefulShellRoute.indexedStack(
        builder: (context, state, studentNavigationShell) {
          return StudentNavigationBottomBar(
            navigationShell: studentNavigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: studentRoute,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: StdHomeView(),
                ),
                name: studentRoute,
                // Restoring the state of the route when the app is resumed
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: courseNavigatorKey,
            routes: [
              GoRoute(
                path: courseRoute,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CoursesView(),
                ),
                name: courseRoute,
                // Restoring the state of the route when the app is resumed
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: attendanceNavigatorKey,
            routes: [
              GoRoute(
                path: attendanceRoute,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: AttendanceViewingScreen(),
                ),
                name: attendanceRoute,
                // Restoring the state of the route when the app is resumed
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: profileNavigatorKey,
            routes: [
              GoRoute(
                path: userProfileRoute,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: UserProfile(),
                ),
                name: userProfileRoute,
                // Restoring the state of the route when the app is resumed
              ),
            ],
          ),
        ],
      ),

      ///-----------Teacher--------------------BottomNavBar---------------------------------------------------///

      StatefulShellRoute.indexedStack(
        builder: (context, state, teacherNavigationShell) {
          return TeacherNavigationBottomBar(
            navigationShell: teacherNavigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            // navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: teacherRoute,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: TeacherHomeView(),
                ),
                name: teacherRoute,
                // Restoring the state of the route when the app is resumed
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: courseNavigatorKey,
            routes: [
              GoRoute(
                path: classRoute,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CoursesView(),
                ),
                name: classRoute,
                // Restoring the state of the route when the app is resumed
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: attendanceNavigatorKey,
            routes: [
              GoRoute(
                path: studentViewRoute,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: StudentListPage(),
                ),
                name: studentViewRoute,
                // Restoring the state of the route when the app is resumed
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: tProfileNavigatorKey,
            routes: [
              GoRoute(
                path: teacherProfileRoute,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: TeacherUserProfile(),
                ),
                // name: userProfileRoute,
                // Restoring the state of the route when the app is resumed
              ),
            ],
          ),
        ],
      ),

      ///-----------------------------------Misc..--------------------------------------------------------///

      GoRoute(
        path: '/createStudentFormPage',
        name: 'createStudentFormPage',
        builder: (context, state) => const CreateStudentFormPage(),
        // Restoring the state of the route when the app is resumed
      ),
      GoRoute(
        path: '/studentListPage',
        name: 'studentListPage',
        builder: (context, state) => const StudentListPage(),
        // Restoring the state of the route when the app is resumed
      ),
      GoRoute(
        path: '/createCourses',
        name: 'createCourses',
        builder: (context, state) => const CreateCourses(),
        // Restoring the state of the route when the app is resumed
      ),
      GoRoute(
        path: '/coursesView',
        name: 'coursesView',
        builder: (context, state) => const CoursesView(),
        // Restoring the state of the route when the app is resumed
      ),
      GoRoute(
        path: '/takeAttendance',
        name: 'takeAttendance',
        builder: (context, state) => const AttendanceTakingScreen(),
        // Restoring the state of the route when the app is resumed
      ),

      GoRoute(
        path: '/settings',
        name: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: '/noteshomepage',
        name: '/noteshomepage',
        builder: (context, state) => const StudyMaterialPage(),
      ),
      GoRoute(
        path: '/noteshomepagestd',
        name: '/noteshomepagestd',
        builder: (context, state) => const StudyMaterialPage(
          showAddButton: false,
        ),
      ),
    ],

    //*if page not found then it will show the page not found from here.
    errorBuilder: (context, state) => Center(
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            const Text("Page Not Found"),
            MaterialButton(
                onPressed: () => context.pop(), child: const Text("Go Home"))
          ],
        )),
      ),
    ),
  );
}
