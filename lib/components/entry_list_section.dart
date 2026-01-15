import 'package:budget_app/shared/sizedbox.dart';
import 'package:budget_app/view-model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app_text.dart';
import 'add_entry_dialog.dart';

class EntryListSection extends ConsumerWidget {
  final EntryType type;
  final bool isWeb;

  const EntryListSection({super.key, required this.type, this.isWeb = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModelProvider);

    final data = type == EntryType.expense ? vm.expenses : vm.incomes;
    // final amounts = type == EntryType.expense
    //     ? vm.expensesAmount
    //     : vm.incomeAmount;

    return Column(
      children: [
        OpenSans(
          text: type == EntryType.expense ? 'Expenses' : 'Incomes',
          fontSize: isWeb ? 18 : 15,
          fontWeight: FontWeight.w500,
        ),
        Container(
          padding: EdgeInsets.all(isWeb ? 10 : 7),
          height: 210,
          width: isWeb ? 200 : 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: ListView.separated(
            itemCount: data.length,
            separatorBuilder: (context, index) => 5.spaceY,
            itemBuilder: (_, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: OpenSans(
                      text: data[index].name,
                      fontSize: isWeb ? 15 : 12,
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    child: OpenSans(
                      text: data[index].amount.toString(),
                      fontSize: isWeb ? 15 : 12,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
