import 'dart:async';

import 'package:budget_app/shared/utilities/pops.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../helper/firebase_exception_handler.dart';
import '../models/model.dart';

final homeViewModelProvider = ChangeNotifierProvider.autoDispose<HomeViewModel>(
  (ref) => HomeViewModel(),
);

class HomeViewModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  List<Model> expenses = [];
  List<Model> incomes = [];

  int totalExpense = 0;
  int totalIncome = 0;
  int budgetLeft = 0;

  void calculate() {
    totalExpense = 0;
    totalIncome = 0;

    for (int i = 0; i < expenses.length; i++) {
      totalExpense += int.parse(expenses[i].amount);
    }
    for (int i = 0; i < incomes.length; i++) {
      totalIncome += int.parse(incomes[i].amount);
    }
    budgetLeft = totalIncome - totalExpense;
    notifyListeners();
  }

  Future<void> addExpense(
    BuildContext context,
    String name,
    String amount,
  ) async {
    try {
      var expenseRef = userRef
          .doc(auth.currentUser?.uid)
          .collection('expenses');
      await expenseRef.add({
        'name': name,
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(),
      });
      if (!context.mounted) return;
      Navigator.pop(context);
      Pops.showToast('Expense Added');
    } catch (e) {
      FirebaseExceptionHandler.handle(e);
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
      if (!context.mounted) return;
      Navigator.pop(context);
      Pops.showToast('Income Added');
    } catch (e) {
      FirebaseExceptionHandler.handle(e);
    }
  }

  void expensesStream() async {
    try {
      await for (var snapshot
          in userRef
              .doc(auth.currentUser?.uid)
              .collection('expenses')
              .snapshots()) {
        expenses = [];
        for (var element in snapshot.docs) {
          expenses.add(Model.fromJson(element.data()));
        }
        notifyListeners();
        calculate();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Expenses stream error: $e');
      }
    }
  }

  void incomesStream() async {
    try {
      await for (var snapshot
          in userRef
              .doc(auth.currentUser?.uid)
              .collection('incomes')
              .snapshots()) {
        incomes = [];
        for (var element in snapshot.docs) {
          incomes.add(Model.fromJson(element.data()));
        }
        notifyListeners();
        calculate();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Incomes stream error: $e');
      }
    }
  }

  Future<void> reset() async {
    try {
      await userRef
          .doc(auth.currentUser?.uid)
          .collection('expenses')
          .get()
          .then((snapshot) {
            for (DocumentSnapshot ds in snapshot.docs) {
              ds.reference.delete();
            }
          });

      await userRef.doc(auth.currentUser?.uid).collection('incomes').get().then(
        (snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        },
      );
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Reset error: $e');
      }
    }
  }
}
