import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/models/expenses_model.dart';
import '../../config/repository/expenses_repository.dart';
import 'config/cubit/expenses_cubit.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(child: expenseBloc()),
      ),
    ));
  }

  Widget expenseBloc() {
    return BlocProvider(
      create: (context) => ExpensesCubit(
        expensesRepository: ExpensesRepository(),
      ),
      child: BlocConsumer<ExpensesCubit, ExpensesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ExpensesLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ExpensesError) {
            return Center(
              child: Text('Cos poszlo nie tak'),
            );
          }
          if (state is ExpensesSuccess) {
            List<Expenses> expensesList = state.expensesList;
            if (expensesList.isNotEmpty) {
              int index = 0;
              Expenses expenses = expensesList[index];

              List<Category> categories = expensesList
                  .expand((element) => element.categories)
                  .take(5)
                  .toList();
              return Container(
                height: 300,
                width: 300,
                color: Colors.amberAccent,
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: Text('Category ID: ${categories[index].id}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Costs: ${categories[index].costs}'),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: categories[index].expenses.length,
                                  itemBuilder: (context, j) {
                                    final expenseItem =
                                        categories[index].expenses[j];
                                    return ListTile(
                                      title: Text('Name: ${expenseItem.name}'),
                                      subtitle:
                                          Text('Cost: ${expenseItem.cost} PLN'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                    Text('${expensesList[index].id}'),
                    Text('${expensesList[index].costs}'),
                  ],
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}

class ExpensesForm extends StatelessWidget {
  const ExpensesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExpensesCategoriesImages extends StatelessWidget {
  const ExpensesCategoriesImages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExpensesCategories extends StatelessWidget {
  const ExpensesCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExpensesAddForm extends StatelessWidget {
  const ExpensesAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
