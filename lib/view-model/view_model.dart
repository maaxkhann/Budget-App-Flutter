import 'dart:async';

import 'package:budget_app/components/app_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final viewModel = ChangeNotifierProvider.autoDispose<ViewModel>(
  (ref) => ViewModel(),
);

final authStateProvider = StreamProvider<bool>((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
});

class ViewModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final GoogleSignIn _google = GoogleSignIn.instance;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  bool isSignedIn = false;
  bool isObscure = true;
  List expensesName = [];
  List expensesAmount = [];
  List incomeName = [];
  List incomeAmount = [];

  // void isLoggedIn() async {
  //   auth.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       isSignedIn = false;
  //     } else {
  //       isSignedIn = true;
  //     }
  //   });
  //   //  notifyListeners();
  // }

  toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((val) => print('user created: ${val.user?.email}'));
    } on FirebaseAuthException catch (e) {
      appDialog(context, e.code.replaceAll(RegExp('\\[.*?\\]'), ''));
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  Future<void> signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((val) => print('user signed in: ${val.user?.email}'));
    } on FirebaseAuthException catch (e) {
      appDialog(context, e.code.replaceAll(RegExp('\\[.*?\\]'), ''));
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  Future<void> signInWithGoogleWeb(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await auth.signInWithPopup(googleAuthProvider);
    } on FirebaseAuthException catch (e) {
      appDialog(context, e.code.replaceAll(RegExp('\\[.*?\\]'), ''));
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  Future<void> signInWithGoogleMobile(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final GoogleSignInAccount account = await _google.authenticate(
        scopeHint: const ['email'],
      );
      final String? idToken = account.authentication.idToken;
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      await auth
          .signInWithCredential(credential)
          .then((value) => print('User signed in: ${value.user?.email}'));
    } on FirebaseAuthException catch (e) {
      appDialog(context, e.code.replaceAll(RegExp('\\[.*?\\]'), ''));
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  Future<void> addExpense(
    BuildContext context,
    String name,
    String amount,
  ) async {
    try {
      await userRef.doc(auth.currentUser?.uid).collection('expenses').add({
        'name': name,
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      appDialog(context, e.code.replaceAll(RegExp('\\[.*?\\]'), ''));
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  Future<void> addIncome(
    BuildContext context,
    String name,
    String amount,
  ) async {
    try {
      await userRef.doc(auth.currentUser?.uid).collection('incomes').add({
        'name': name,
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      appDialog(context, e.code.replaceAll(RegExp('\\[.*?\\]'), ''));
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
