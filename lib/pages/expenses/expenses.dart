import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/common/helpers/mysaving_nav.dart';
import 'package:mysavingapp/config/repository/expenses_repository.dart';
import 'package:mysavingapp/pages/expenses/config/cubit/expense_cubit.dart';
import 'package:mysavingapp/pages/expenses/helpers/expenses_categories_column_list.dart';
import 'package:mysavingapp/pages/expenses/helpers/expenses_categories_row_list.dart';
import '../../config/models/expenses_model.dart';

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
              ExpensesCategoriesRowList(),
              ExpensesCategoriesColumnList()
            ],
          ),
        ),
      ),
    );
  }
}
