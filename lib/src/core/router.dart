import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_mgt/src/auth/views/student_auth_gate.dart';
import 'package:student_mgt/src/constants/routes.dart';
import 'package:student_mgt/src/student/bottom_nav_bar.dart';
import 'package:student_mgt/src/auth/views/choice_login.dart';
import 'package:student_mgt/src/core/splash_view.dart';
import '../auth/views/admin_auth_gate.dart';
import '../auth/views/teacher_auth_gate.dart';
import '../profile/user_profile.dart';
import '../shared/settings/settings_controller.dart';
import '../shared/settings/settings_service.dart';
import '../shared/settings/settings_view.dart';
import '../student/home_view.dart';

part 'router.g.dart';

SettingsService settingsService = SettingsService();
SettingsController settingsController = SettingsController(settingsService);

// This is the router provider that will be used in the main.dart file
// to pass the router to the MaterialApp.router
@riverpod
GoRouter Router(RouterRef ref) {
  // final userRole = ref.watch(userRoleProvider);

  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final adminNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'admin');
  final studentNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'student');
  final teacherNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');
  final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  final profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    //* temporary solution for checking if user is logged in or not and where to send him
    initialLocation: loginChoiceRoute,

    /// Forwards diagnostic messages to the dart:developer log() API.
    debugLogDiagnostics: true,
    // redirect: (context, state) async {},
    routes: [
      GoRoute(
        path: splashRoute,
        name: splashRoute,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashView(),
        ),
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

      ///------------------------------------------BottomNavBar---------------------------------------------------///

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MyAppNavigationBottomBar(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: studentRoute,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeView(),
                ),
                name: studentRoute,
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
              ),
            ],
          ),
        ],
      ),

      ///-----------------------------------Misc..--------------------------------------------------------///

      GoRoute(
        path: SettingsView.path,
        name: SettingsView.path,
        builder: (context, state) =>
            SettingsView(controller: settingsController),
      ),
    ],

    //*if page not found then it will show the page not found from here.
    errorBuilder: (context, state) => const Center(
      child: Scaffold(body: Text("Page Not Found")),
    ),
  );
}

enum UserRole {
  student,
  teacher,
  admin,
  unauthenticated,
  loading,
  error,
  unknown,
}
