import 'package:budget_app/components/app_text.dart';
import 'package:budget_app/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../helper/url_launch_method.dart';
import '../view-model/view_model.dart';

class ExpenseViewMobile extends HookConsumerWidget {
  const ExpenseViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseNameCont = TextEditingController();
    final expenseAmountCont = TextEditingController();
    final incomeNameCont = TextEditingController();
    final incomeAmountCont = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
          centerTitle: true,
          title: OpenSans(text: 'Dashboard', fontSize: 20, color: Colors.white),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
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
                  IconButton(
                    onPressed: () async =>
                        launchUrlMethod('https://x.com/MaazKha65069365'),
                    icon: SvgPicture.asset(
                      'assets/twitter.svg',
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
        body: ListView(
          children: [
            SizedBox(height: 40),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  height: 240,
                  width: width / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OpenSans(
                            text: 'Budget Left',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          OpenSans(
                            text: 'Total Expense',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          OpenSans(
                            text: 'Total Income',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        indent: 40,
                        endIndent: 40,
                      ),
                      Column(
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 10,
              children: [
                SizedBox(
                  height: 40,
                  width: 150,
                  child: MaterialButton(
                    splashColor: Colors.grey,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actionsAlignment: MainAxisAlignment.center,
                          contentPadding: EdgeInsets.all(32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Form(
                            key: formKey,
                            child: Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  controller: expenseNameCont,
                                  title: 'Name',
                                  hintText: 'Enter Name',
                                  width: 150,
                                  validator: (text) {
                                    if (text.toString().isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  controller: expenseAmountCont,
                                  title: 'Amount',
                                  hintText: 'Enter Amount',
                                  isNumber: true,
                                  width: 150,
                                  validator: (text) {
                                    if (text.toString().isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            MaterialButton(
                              splashColor: Colors.grey,
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  viewModelProvider.addExpense(
                                    context,
                                    expenseNameCont.text.trim(),
                                    expenseAmountCont.text.trim(),
                                  );
                                }
                              },
                              child: OpenSans(
                                text: 'Save',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 14),
                        OpenSans(
                          text: 'Add Expense',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),

                //Add income button
                SizedBox(
                  height: 40,
                  width: 150,
                  child: MaterialButton(
                    splashColor: Colors.grey,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actionsAlignment: MainAxisAlignment.center,
                          contentPadding: EdgeInsets.all(32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Form(
                            key: formKey,
                            child: Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  controller: incomeNameCont,
                                  title: 'Name',
                                  hintText: 'Enter Name',
                                  width: 150,
                                  validator: (text) {
                                    if (text.toString().isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  controller: incomeAmountCont,
                                  title: 'Amount',
                                  hintText: 'Enter Amount',
                                  isNumber: true,
                                  width: 150,
                                  validator: (text) {
                                    if (text.toString().isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            MaterialButton(
                              splashColor: Colors.grey,
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  viewModelProvider.addIncome(
                                    context,
                                    incomeNameCont.text.trim(),
                                    incomeAmountCont.text.trim(),
                                  );
                                }
                              },
                              child: OpenSans(
                                text: 'Save',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 14),
                        OpenSans(
                          text: 'Add Income',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
