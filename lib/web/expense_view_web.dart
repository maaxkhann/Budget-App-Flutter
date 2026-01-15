import 'package:budget_app/components/custom_appbar.dart';
import 'package:budget_app/components/custom_drawer.dart';
import 'package:budget_app/components/dashboard_card.dart';
import 'package:budget_app/shared/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/add_action_buttons.dart';
import '../components/add_entry_dialog.dart';
import '../components/entry_list_section.dart';
import '../shared/extensions/build_context.dart';
import '../view-model/home_view_model.dart';

class ExpenseViewWeb extends HookConsumerWidget {
  const ExpenseViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(homeViewModelProvider);
    final width = context.width;

    useEffect(() {
      viewModelProvider.expensesStream();
      viewModelProvider.incomesStream();
      return null;
    }, []);
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: ListView(
        children: [
          50.spaceY,
          // image + add income + total calculation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/login_image.png',
                  width: width / 2.6,
                ),
              ),
              //Add income and expense
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 300,
                  child: AddActionButtons(isWeb: true),
                ),
              ),
              30.spaceX,
              Expanded(
                flex: 3,
                child: DashboardCard(
                  budgetLeft: viewModelProvider.budgetLeft,
                  totalExpense: viewModelProvider.totalExpense,
                  totalIncome: viewModelProvider.totalIncome,
                  isWeb: true,
                ),
              ),
            ],
          ),
          40.spaceY,
          Divider(indent: width / 4, endIndent: width / 4, thickness: 3),
          50.spaceY,

          //Expenses + Income list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EntryListSection(type: EntryType.expense, isWeb: true),
                EntryListSection(type: EntryType.income, isWeb: true),
              ],
            ),
          ),
          30.spaceY,
        ],
      ),
    );
  }
}
