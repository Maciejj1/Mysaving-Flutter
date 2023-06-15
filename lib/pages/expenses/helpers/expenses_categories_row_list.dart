import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/models/expenses_model.dart';
import '../../../config/repository/expenses_repository.dart';
import '../config/cubit/expense_cubit.dart';

class ExpensesCategoriesRowList extends StatelessWidget {
  const ExpensesCategoriesRowList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExpenseCubit(dashboardRepository: ExpensesRepository())..getSummary(),
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

            return Column(
              children: [
                Container(
                  height: 160,
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
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 70,
                                  height: 60,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.category,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        category.name ?? '',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${calculatePercentage(totalCategoryCosts, expenses.costs ?? 0).toStringAsFixed(1)}%',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Container();
        }
        return Container();
      },
    );
  }
}
