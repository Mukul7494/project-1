import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_mgt/src/core/bottom_nav_bar.dart';
import 'package:student_mgt/src/core/choice_login.dart';
import 'package:student_mgt/src/core/splash_view.dart';
import 'package:student_mgt/src/utils/settings/settings_controller.dart';
import '../auth/admin_auth_state.dart';
import '../auth/student_auth_gate.dart';
import '../auth/teacher_auth_gate.dart';
import '../auth/ui/login_with_phone.dart';
import '../auth/ui/phone_verification.dart';
import '../auth/user.dart';
import '../profile/user_profile.dart';
import '../utils/settings/settings_service.dart';
import '../utils/settings/settings_view.dart';
import 'home_view.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _adminNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'admin');
final _studentNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'student');
final _teacherNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

SettingsService settingsService = SettingsService();
SettingsController settingsController = SettingsController(settingsService);

// This is the router provider that will be used in the main.dart file
// to pass the router to the MaterialApp.router
@riverpod
GoRouter Router(RouterRef ref) {
  final userStream = ref.watch(userStreamProvider);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    //* temporary solution for checking if user is logged in or not and where to send him
    initialLocation: SplashView.path,

    /// Forwards diagnostic messages to the dart:developer log() API.
    debugLogDiagnostics: true,
    redirect: (context, state) async {},
    routes: [
      GoRoute(
        path: SplashView.path,
        name: SplashView.path,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashView(),
        ),
      ),

      ///--------------------------------------------Auth---------------------------------------------------------///

      GoRoute(
        path: LoginChoicePage.path,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginChoicePage(),
        ),
        name: LoginChoicePage.path,
      ),
      GoRoute(
        path: AdminAuthGate.path,
        name: AdminAuthGate.path,
        builder: (context, state) {
          return const AdminAuthGate();
        },
      ),
      GoRoute(
        path: TeacherAuthGate.path,
        name: TeacherAuthGate.path,
        builder: (context, state) {
          return const TeacherAuthGate();
        },
      ),
      GoRoute(
        path: StudentAuthGate.path,
        builder: (context, state) {
          return const StudentAuthGate();
        },
        name: StudentAuthGate.path,
      ),
      GoRoute(
        path: '/phoneloginPage',
        builder: (context, state) => const PhoneLoginPage(),
      ),
      GoRoute(
        path: '/phoneVerificationPage',
        builder: (context, state) => PhoneVerificationPage(
          phoneVerificationId:
              state.uri.queryParameters['phoneVerificationId']!,
        ),
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
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: HomeView.path,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeView(),
                ),
                name: HomeView.path,
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: UserProfile(),
                ),
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

      /*
      GoRoute(
        path: '/admin',
        name: 'admin',
        // Use a guard or middleware to ensure authorization
        //TODO: ADD Guard
        builder: (context, State) => AdminScreen(),
      ),
      GoRoute(
        path: '/student',
        name: 'student',
        builder: (context, state) => StudentScreen(),
      ),
      GoRoute(
        path: '/teacher',
        name: 'teacher',
        builder: (context, State) => TeacherScreen(),
      ),
      */
    ],

    //*if page not found then it will show the page not found from here.
    errorBuilder: (context, state) => const Center(
      child: Scaffold(body: Text("Page Not Found")),
    ),
  );
}
