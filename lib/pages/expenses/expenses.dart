import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/config/repository/expenses_repository.dart';
import 'package:mysavingapp/pages/expenses/config/cubit/expense_cubit.dart';
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
              expenseBloc(),
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseBloc() {
    return BlocProvider(
      create: (context) =>
          ExpenseCubit(dashboardRepository: ExpensesRepository())..getSummary(),
      child: BlocConsumer<ExpenseCubit, ExpenseState>(
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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
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
                                      itemBuilder:
                                          (BuildContext context, index) {
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
                                        padding:
                                            const EdgeInsets.only(right: 20),
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
      ),
    );
  }
}
