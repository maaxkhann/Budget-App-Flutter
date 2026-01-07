import 'package:budget_app/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../helper/url_launch_method.dart';
import '../view-model/view_model.dart';

class ExpenseViewMobile extends HookConsumerWidget {
  const ExpenseViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    final width = MediaQuery.of(context).size.width;
    int totalExpense = 0;
    int totalIncome = 0;

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
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white, size: 30),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: CircleAvatar(
                    radius: 180,
                    backgroundColor: Colors.white,
                    child: Image(
                      height: 100,
                      image: AssetImage('assets/logo.png'),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.black,
                height: 50,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  //   elevation: 20,
                ),
                onPressed: () async => await viewModelProvider.logout(),
                child: OpenSans(
                  text: 'Logout',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async => launchUrlMethod(
                      'https://www.instagram.com/maaz.514?utm_source=qr&igsh=aHh1cDV0bDE2eW11',
                    ),
                    icon: SvgPicture.asset(
                      'assets/instagram.svg',
                      width: 35,
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
