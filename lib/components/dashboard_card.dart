import 'package:flutter/material.dart';
import 'app_text.dart';

class DashboardCard extends StatelessWidget {
  final int budgetLeft;
  final int totalExpense;
  final int totalIncome;
  final bool isWeb;

  const DashboardCard({
    super.key,
    required this.budgetLeft,
    required this.totalExpense,
    required this.totalIncome,
    this.isWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(isWeb ? 10 : 15),
        height: isWeb ? 300 : 240,
        //  width: isWeb ? width / 3 : width / 1.5,
        constraints: BoxConstraints(minWidth: 210, maxWidth: 300),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LabelColumn(isWeb: isWeb),
            const VerticalDivider(
              color: Colors.grey,
              indent: 40,
              endIndent: 40,
            ),
            ValueColumn(
              budgetLeft: budgetLeft,
              totalExpense: totalExpense,
              totalIncome: totalIncome,
              isWeb: isWeb,
            ),
          ],
        ),
      ),
    );
  }
}

class LabelColumn extends StatelessWidget {
  final bool isWeb;
  const LabelColumn({super.key, required this.isWeb});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpenSans(
          text: 'Budget Left',
          fontSize: isWeb ? 17 : 14,
          color: Colors.white,
        ),
        OpenSans(
          text: 'Total Expense',
          fontSize: isWeb ? 17 : 14,
          color: Colors.white,
        ),
        OpenSans(
          text: 'Total Income',
          fontSize: isWeb ? 17 : 14,
          color: Colors.white,
        ),
      ],
    );
  }
}

class ValueColumn extends StatelessWidget {
  final int budgetLeft;
  final int totalExpense;
  final int totalIncome;
  final bool isWeb;

  const ValueColumn({
    super.key,
    required this.budgetLeft,
    required this.totalExpense,
    required this.totalIncome,
    required this.isWeb,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpenSans(
          text: budgetLeft.toString(),
          fontSize: isWeb ? 17 : 14,
          color: Colors.white,
        ),
        OpenSans(
          text: totalExpense.toString(),
          fontSize: isWeb ? 17 : 14,
          color: Colors.white,
        ),
        OpenSans(
          text: totalIncome.toString(),
          fontSize: isWeb ? 17 : 14,
          color: Colors.white,
        ),
      ],
    );
  }
}
