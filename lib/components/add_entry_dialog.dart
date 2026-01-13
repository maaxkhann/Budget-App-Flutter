import 'package:budget_app/view-model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'custom_textfield.dart';
import 'app_text.dart';

enum EntryType { expense, income }

class AddEntryDialog extends ConsumerWidget {
  final EntryType type;

  AddEntryDialog({super.key, required this.type});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(homeViewModelProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(32),
      title: Form(
        key: _formKey,
        child: Row(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextField(
              controller: _nameController,
              title: 'Name',
              hintText: 'Enter Name',
              width: 150,
              validator: (text) => text!.isEmpty ? 'Required' : null,
            ),
            CustomTextField(
              controller: _amountController,
              title: 'Amount',
              hintText: 'Enter Amount',
              isNumber: true,
              width: 150,
              validator: (text) => text!.isEmpty ? 'Required' : null,
            ),
          ],
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: MaterialButton(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (type == EntryType.expense) {
                  vm.addExpense(
                    context,
                    _nameController.text.trim(),
                    _amountController.text.trim(),
                  );
                } else {
                  vm.addIncome(
                    context,
                    _nameController.text.trim(),
                    _amountController.text.trim(),
                  );
                }
              }
            },
            child: const OpenSans(
              text: 'Save',
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
