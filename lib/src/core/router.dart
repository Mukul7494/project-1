import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_mgt/src/core/bottom_nav_bar.dart';
import 'package:student_mgt/src/utils/settings/settings_controller.dart';
import '../auth/ui/login_with_phone.dart';
import '../auth/ui/phone_verification.dart';
import '../auth/ui/signup_with_email.dart';
import '../profile/user_profile.dart';
import '../utils/settings/settings_service.dart';
import '../utils/settings/settings_view.dart';
import 'home_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

SettingsService settingsService = SettingsService();
SettingsController settingsController = SettingsController(settingsService);

// This is the router provider that will be used in the main.dart file
// to pass the router to the MaterialApp.router
final goRouter = Provider<GoRouter>((ref) {
  // final FirebaseAuthServices auth = FirebaseAuthServices();
  // final user = auth.getUser();
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    //* temporary solution for checking if user is logged in or not and where to send him
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginPage(),
        ),
      ),
      GoRoute(
          path: '/phoneloginPage',
          builder: (context, state) => const PhoneLoginPage()),
      GoRoute(
        path: '/phoneVerificationPage',
        builder: (context, state) => PhoneVerificationPage(
          phoneVerificationId:
              state.uri.queryParameters['phoneVerificationId']!,
        ),
      ),
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
                path: '/home',
                name: 'home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: UserProfile(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: SettingsView.routeName,
        name: SettingsView.routeName,
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
});
