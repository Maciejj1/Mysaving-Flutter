import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/models/expenses_model.dart';
import '../../../config/repository/expenses_repository.dart';
import '../config/cubit/expense_cubit.dart';

class ExpensesCategoriesColumnList extends StatelessWidget {
  const ExpensesCategoriesColumnList({super.key});

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

            return Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text('Expenses ID: ${expensesList[index].id ?? ''}'),
                  Text('Total Costs: ${expensesList[index].costs ?? ''}'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: ListView.builder(
                                    itemCount: category.expenses!.length,
                                    itemBuilder: (BuildContext context, index) {
                                      Expense expense =
                                          category.expenses![index];
                                      return Card(
                                        child: Column(
                                          children: [
                                            Text(
                                                'Expense Name: ${expense.name}'),
                                            Text(
                                                'Expense Cost: ${expense.cost}'),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            width: 380,
                            height: 60,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                              'Category Name: ${category.name}'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                          'Costs: ${category.costs ?? ''}'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
