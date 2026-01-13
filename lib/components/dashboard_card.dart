import 'package:flutter/material.dart';
import 'app_text.dart';

class DashboardCard extends StatelessWidget {
  final int budgetLeft;
  final int totalExpense;
  final int totalIncome;

  const DashboardCard({
    super.key,
    required this.budgetLeft,
    required this.totalExpense,
    required this.totalIncome,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 240,
        width: width / 1.5,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const _LabelColumn(),
            const VerticalDivider(
              color: Colors.grey,
              indent: 40,
              endIndent: 40,
            ),
            _ValueColumn(
              budgetLeft: budgetLeft,
              totalExpense: totalExpense,
              totalIncome: totalIncome,
            ),
          ],
        ),
      ),
    );
  }
}

class _LabelColumn extends StatelessWidget {
  const _LabelColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        OpenSans(text: 'Budget Left', fontSize: 14, color: Colors.white),
        OpenSans(text: 'Total Expense', fontSize: 14, color: Colors.white),
        OpenSans(text: 'Total Income', fontSize: 14, color: Colors.white),
      ],
    );
  }
}

class _ValueColumn extends StatelessWidget {
  final int budgetLeft;
  final int totalExpense;
  final int totalIncome;

  const _ValueColumn({
    required this.budgetLeft,
    required this.totalExpense,
    required this.totalIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpenSans(
          text: budgetLeft.toString(),
          fontSize: 14,
          color: Colors.white,
        ),
        OpenSans(
          text: totalExpense.toString(),
          fontSize: 14,
          color: Colors.white,
        ),
        OpenSans(
          text: totalIncome.toString(),
          fontSize: 14,
          color: Colors.white,
        ),
      ],
    );
  }
}
