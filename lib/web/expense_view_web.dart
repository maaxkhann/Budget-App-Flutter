import 'package:budget_app/components/custom_appbar.dart';
import 'package:budget_app/components/custom_drawer.dart';
import 'package:budget_app/components/dashboard_card.dart';
import 'package:budget_app/shared/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/add_entry_dialog.dart';
import '../components/app_text.dart';
import '../components/entry_list_section.dart';
import '../shared/extensions/build_context.dart';
import '../view-model/home_view_model.dart';

class ExpenseViewWeb extends HookConsumerWidget {
  const ExpenseViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(homeViewModelProvider);
    final width = context.width;
    final height = context.height;
    int totalExpense = 0;
    int totalIncome = 0;
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add expense
                      SizedBox(
                        height: 45,
                        width: 160,
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  AddEntryDialog(type: EntryType.expense),
                            );
                          },
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.add, color: Colors.white),
                                OpenSans(
                                  text: 'Add Expense',
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      30.spaceY,
                      //Add Income
                      SizedBox(
                        height: 45,
                        width: 160,
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  AddEntryDialog(type: EntryType.income),
                            );
                          },
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.add, color: Colors.white),
                                OpenSans(
                                  text: 'Add Income',
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              30.spaceX,
              Expanded(
                flex: 3,
                child: DashboardCard(
                  budgetLeft: budgetLeft,
                  totalExpense: totalExpense,
                  totalIncome: totalIncome,
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
