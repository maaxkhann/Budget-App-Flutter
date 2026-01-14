import 'package:budget_app/shared/extensions/build_context.dart';
import 'package:budget_app/shared/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/add_action_buttons.dart';
import '../components/add_entry_dialog.dart';
import '../components/custom_appbar.dart';
import '../components/custom_drawer.dart';
import '../components/dashboard_card.dart';
import '../components/entry_list_section.dart';
import '../view-model/home_view_model.dart';

// bool isLoading = true;

class ExpenseViewMobile extends HookConsumerWidget {
  const ExpenseViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(homeViewModelProvider);
    int totalExpense = 0;
    int totalIncome = 0;
    // if (isLoading) {
    //   viewModelProvider.expensesStream();
    //   viewModelProvider.incomesStream();
    //   isLoading = false;
    // }
    useEffect(() {
      viewModelProvider.expensesStream();
      viewModelProvider.incomesStream();
      return null;
    }, []);

    void calculate() {
      for (int i = 0; i < viewModelProvider.expensesAmount.length; i++) {
        totalExpense += int.parse(viewModelProvider.expensesAmount[i]);
      }
      for (int i = 0; i < viewModelProvider.incomeAmount.length; i++) {
        totalIncome += int.parse(viewModelProvider.incomeAmount[i]);
      }
    }

    calculate();
    int budgetLeft = totalIncome - totalExpense;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: ListView(
          children: [
            40.spaceY,
            Column(
              children: [
                DashboardCard(
                  budgetLeft: budgetLeft,
                  totalExpense: totalExpense,
                  totalIncome: totalIncome,
                ),
              ],
            ),
            40.spaceY,
            const AddActionButtons(),

            30.spaceY,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EntryListSection(type: EntryType.expense),
                  EntryListSection(type: EntryType.income),
                ],
              ),
            ),
            30.spaceY,
          ],
        ),
      ),
    );
  }
}
