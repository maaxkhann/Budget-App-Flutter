import 'package:flutter/material.dart';
import 'add_entry_dialog.dart';
import 'app_text.dart';

class AddActionButtons extends StatelessWidget {
  const AddActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _AddButton(title: 'Add Expense', type: EntryType.expense),
        _AddButton(title: 'Add Income', type: EntryType.income),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  final String title;
  final EntryType type;

  const _AddButton({required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: MaterialButton(
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddEntryDialog(type: type),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.add, color: Colors.white, size: 14),
            OpenSans(text: title, fontSize: 14, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
