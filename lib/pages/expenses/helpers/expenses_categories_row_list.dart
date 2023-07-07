import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';

import '../../../data/models/expenses_model.dart';
import '../../../data/repositories/expenses_repository.dart';
import '../config/cubit/expense_cubit.dart';

class ExpensesCategoriesRowList extends StatelessWidget {
  const ExpensesCategoriesRowList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExpenseCubit(expensesRepository: ExpensesRepository())..getSummary(),
      child: expenseBloc(),
    );
  }

  Widget expenseBloc() {
    return BlocConsumer<ExpenseCubit, ExpenseState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ExpenseLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is ExpenseError) {
          return Center(
            child: Text('Cos poszlo nie tak'),
          );
        }
        if (state is ExpenseSuccess) {
          List<Expenses> expensesList = state.expenses;
          if (expensesList.isNotEmpty) {
            int index = 0;
            Expenses expenses = expensesList[index];
            double calculatePercentage(double costs, int totalCosts) {
              return (costs / totalCosts) * 100.0;
            }

            List<Category> categories = expensesList
                .expand((element) => element.categories)
                .take(5)
                .toList();

            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: 380,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        Category category = categories[index];
                        double totalCategoryCosts = category.expenses!
                            .map((expense) => expense.cost ?? 0)
                            .reduce((a, b) => a + b)
                            .toDouble();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 75,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MySavingColors.defaultCategories,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                          width: 35,
                                          child: Image.asset(category.url!))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 75,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${calculatePercentage(totalCategoryCosts, expenses.costs ?? 0).toStringAsFixed(0)}%',
                                        style: TextStyle(
                                          color: MySavingColors.defaultGreyText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }
        return Container();
      },
    );
  }
}
