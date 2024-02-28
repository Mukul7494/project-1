import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../utils/widgets/toast_msg.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getUser() {
    return _auth.currentUser;
  }

  Future signInWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      Logger().i(userCredential.user!.uid);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      errorMessage(error.message.toString());
      Logger().e(email, error: password);
    }
  }

  Future signUpWithEmail(
      {required String email, required String password}) async {
    try {
      final signUp = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      successMessage("Account Created Successfully");
      Logger().i(signUp.user!.uid);
      return signUp;
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      errorMessage(e.message.toString());
      return null;
    }
  }

  void signOut(BuildContext context) {
    try {
      _auth.signOut();
      FirebaseAuth.instance.signOut();
      context.go('/loginPage');
      Logger().i("Sign Out");
    } on FirebaseAuthException catch (e) {
      Logger().e(e.message);
    }
  }

  Future verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    try {
      final phoneVerify = _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (_) {},
          verificationFailed: (FirebaseAuthException e) {
            errorMessage(e.message.toString());
            Logger().e(e.message);
          },
          codeSent: (String verificationId, int? verificationCode) {
            context.go(
                '/phoneVerificationPage?phoneVerificationId=$verificationId');
          },
          codeAutoRetrievalTimeout: (e) {
            errorMessage(e.toString());
          });
      Logger().i(phoneVerify);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.message);
    }
  }

  Future signInWithPhone(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      final credentials = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      // ignore: unused_local_variable
      final phoneLogin = await _auth
          .signInWithCredential(credentials)
          .then((value) => context.go('/home'));

      Logger().i(credentials);
      // Logger().i(phoneLogin);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.message);
    }
  }
}
