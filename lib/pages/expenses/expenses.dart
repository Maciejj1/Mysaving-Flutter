import 'package:flutter/material.dart';
import 'package:mysavingapp/common/helpers/mysaving_nav.dart';
import 'package:mysavingapp/pages/expenses/helpers/expenses_adding_form.dart';
import 'package:mysavingapp/pages/expenses/helpers/expenses_categories_column_list.dart';
import 'package:mysavingapp/pages/expenses/helpers/expenses_categories_row_list.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySavingUpNav(),
              SizedBox(
                height: 20,
              ),
              ExpensesCategoriesRowList(),
              ExpensesCategoriesColumnList(),
              ExpensesAddingForm()
            ],
          ),
        ),
      ),
    );
  }
}
