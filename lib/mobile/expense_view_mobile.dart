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

class ExpenseViewMobile extends HookConsumerWidget {
  const ExpenseViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(homeViewModelProvider);

    useEffect(() {
      viewModelProvider.expensesStream();
      viewModelProvider.incomesStream();
      return null;
    }, []);

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
                  budgetLeft: viewModelProvider.budgetLeft,
                  totalExpense: viewModelProvider.totalExpense,
                  totalIncome: viewModelProvider.totalIncome,
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
