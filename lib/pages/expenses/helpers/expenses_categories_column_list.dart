import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';

import '../../../data/models/expenses_model.dart';
import '../../../data/repositories/expenses_repository.dart';
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
            List<Category> categories = expensesList
                .expand((element) => element.categories)
                .take(5)
                .toList();

            return Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Kategorie wydatków',
                    style: TextStyle(color: MySavingColors.defaultGreyText),
                  ),
                  Gap(10),
                  SizedBox(
                    width: 370,
                    height: 260,
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  MySavingColors.defaultBackgroundPage,
                              builder: (BuildContext context) {
                                return ListView.builder(
                                  itemCount: category.expenses!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    Expense expense = category.expenses![index];
                                    return Container(
                                      width: 200,
                                      height: 50,
                                      child: Card(
                                        color: MySavingColors.defaultCategories,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: Text(
                                                      '${expense.name}',
                                                      style: TextStyle(
                                                        color: MySavingColors
                                                            .defaultExpensesText,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: Text(
                                                    '-${expense.cost} PLN',
                                                    style: TextStyle(
                                                      color: MySavingColors
                                                          .defaultRed,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            child: Card(
                              color: MySavingColors.defaultCategories,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${category.name}',
                                            style: TextStyle(
                                              color: MySavingColors
                                                  .defaultExpensesText,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        '-${category.costs ?? ''} PLN',
                                        style: TextStyle(
                                          color: MySavingColors.defaultRed,
                                          fontSize: 16,
                                        ),
                                      ),
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
