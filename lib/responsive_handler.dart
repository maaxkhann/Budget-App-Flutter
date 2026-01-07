import 'package:budget_app/mobile/expense_view_mobile.dart';
import 'package:budget_app/mobile/login_view_mobile.dart';
import 'package:budget_app/view-model/view_model.dart';
import 'package:budget_app/web/expense_view_web.dart';
import 'package:budget_app/web/login_view_web.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponsiveHandler extends ConsumerWidget {
  const ResponsiveHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text(e.toString()))),
      data: (isSignedIn) {
        if (isSignedIn) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return const ExpenseViewWeb();
              } else {
                return const ExpenseViewMobile();
              }
            },
          );
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return LoginViewWeb();
              } else {
                return const LoginViewMobile();
              }
            },
          );
        }
      },
    );
  }
}
