import 'package:budget_app/components/custom_button.dart';
import 'package:flutter/material.dart';

import 'add_entry_dialog.dart';

class AddActionButtons extends StatelessWidget {
  final bool isWeb;
  const AddActionButtons({super.key, this.isWeb = false});

  @override
  Widget build(BuildContext context) {
    return !isWeb
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                title: 'Add Expense',
                height: 40,
                icon: Icon(Icons.add, color: Colors.white, size: 14),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddEntryDialog(type: EntryType.expense),
                  );
                },
              ),
              CustomButton(
                title: 'Add Expense',
                height: 40,
                icon: Icon(Icons.add, color: Colors.white, size: 14),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddEntryDialog(type: EntryType.income),
                  );
                },
              ),
            ],
          )
        : Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add expense
              CustomButton(
                title: 'Add Expense',
                height: 45,
                width: 160,
                icon: Icon(Icons.add, color: Colors.white, size: 14),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddEntryDialog(type: EntryType.expense),
                  );
                },
              ),

              CustomButton(
                title: 'Add Income',
                height: 45,
                width: 160,
                icon: Icon(Icons.add, color: Colors.white, size: 14),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddEntryDialog(type: EntryType.income),
                  );
                },
              ),
            ],
          );
  }
}
