import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

@riverpod
Stream<User?> UserStream(UserStreamRef ref) async* {
  await for (final user in FirebaseAuth.instance.authStateChanges()) {
    yield user;
  }
}