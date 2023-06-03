import 'package:flutter/material.dart';
import '../../config/models/category_model.dart';
import '../../config/models/expense_model.dart';
import '../../config/repository/database.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Category>? expenseData;

  @override
  void initState() {
    super.initState();
    _getExpenseData();
  }

  Future<void> _getExpenseData() async {
    // final data = await DatabaseService().readExpenseData();
    setState(() {
      // expenseData = data as List<Category>?;
      expenseData = [
        Category(
          id: 1,
          name: 'Category 1',
          url: 'URL 1',
          costs: 100,
          expenses: [
            Expense(name: 'Expense 1', cost: 50),
            Expense(name: 'Expense 2', cost: 50),
          ],
        ),
        Category(
          id: 2,
          name: 'Category 2',
          url: 'URL 2',
          costs: 200,
          expenses: [
            Expense(name: 'Expense 3', cost: 100),
            Expense(name: 'Expense 4', cost: 100),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Hej tu expenses"),
              if (expenseData != null)
                Column(
                  children: expenseData!.map((category) {
                    return Column(
                      children: [
                        Text('Category Name: ${category.name}'),
                        Text('Total Costs: ${category.costs.toString()}'),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: category.expenses.length,
                          itemBuilder: (context, index) {
                            final expense = category.expenses[index];
                            return Column(
                              children: [
                                Text('Expense Name: ${expense.name}'),
                                Text(
                                    'Expense Cost: ${expense.cost.toString()}'),
                                Divider(),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }).toList(),
                )
              else
                Text('No expense data found'),
              ElevatedButton(
                onPressed: _getExpenseData,
                child: Text('Pobierz dane wydatków'),
              ),
              ElevatedButton(
                onPressed: () {}, // Implement the logout functionality
                child: Text('Wyloguj'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
