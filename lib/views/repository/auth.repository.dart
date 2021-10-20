import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_originator_poc/config/providers.dart';
import 'package:loan_originator_poc/config/router.dart';

abstract class BaseAuthRepository {
  Stream<User> get authStateChanges;

  Future<void> signIn();

  Future<void> phoneNumberVerification(
      BuildContext context, String verificationCode);

  User getCurrentUser();

  Future<void> signOut();

  Future<void> signInWithCredential(BuildContext context , PhoneAuthCredential credential);
}

class AuthRepository implements BaseAuthRepository {
  final Reader _read;

  AuthRepository(this._read);

  @override
  // TODO: implement authStateChanges
  Stream<User> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  User getCurrentUser() => _read(firebaseAuthProvider).currentUser;

  @override
  Future<void> signIn() async {
    // TODO: implement signIn
    await _read(firebaseAuthProvider).signInAnonymously();
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    await _read(firebaseAuthProvider).signOut();
  }

  @override
  Future<void> phoneNumberVerification(
      BuildContext context, String phoneNumber) async {
    User user = getCurrentUser();
    // TODO: implement phoneNumberVerification
    await _read(firebaseAuthProvider).verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (credential.smsCode != null) {
            try {
              UserCredential userCredential =
                  await user.linkWithCredential(credential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'provider-already-linked') {
                await _read(firebaseAuthProvider)
                    .signInWithCredential(credential)
                    .then((value) => phoneAuthVerified(value.user, context));
              }
            }
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.message);
        },
        codeSent: (String verificationId, int resendToken) {
          Navigator.pushNamed(context, AppRoutes.phoneNumberVerificationRoute, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  @override
  Future<void> signInWithCredential(
      BuildContext context, PhoneAuthCredential credential) async {
    await _read(firebaseAuthProvider)
        .signInWithCredential(credential)
        .then((value) => phoneAuthVerified(value.user, context));
  }

  phoneAuthVerified(User user, BuildContext context) {
    if (user != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.dashboardRoute, (route) => false);
    }
  }
}
