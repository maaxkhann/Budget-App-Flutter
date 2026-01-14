import 'dart:async';
import 'package:budget_app/shared/utilities/pops.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../helper/firebase_exception_handler.dart';

final authViewModelProvider = ChangeNotifierProvider.autoDispose<AuthViewModel>(
  (ref) => AuthViewModel(),
);

final authStateProvider = StreamProvider<bool>((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
});

class AuthViewModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final GoogleSignIn _google = GoogleSignIn.instance;

  bool isSignedIn = false;
  bool isObscure = true;

  toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Pops.showToast('Registered Successfully');
    } catch (e) {
      FirebaseExceptionHandler.handle(e);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Pops.showToast('Logged In Successfully');
    } catch (e) {
      FirebaseExceptionHandler.handle(e);
    }
  }

  Future<void> signInWithGoogleWeb(String email, String password) async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await auth.signInWithPopup(googleAuthProvider);
      Pops.showToast('Logged In Successfully');
    } catch (e) {
      FirebaseExceptionHandler.handle(e);
    }
  }

  Future<void> signInWithGoogleMobile(String email, String password) async {
    try {
      final GoogleSignInAccount account = await _google.authenticate(
        scopeHint: const ['email'],
      );
      final String? idToken = account.authentication.idToken;
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      await auth.signInWithCredential(credential);
      Pops.showToast('Logged In Successfully');
    } catch (e) {
      FirebaseExceptionHandler.handle(e);
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      FirebaseExceptionHandler.handle(e);
    }
  }
}
