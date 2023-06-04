import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../config/models/category_model.dart';
import '../../config/singleton/user_manager.dart';

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
    getData();
  }

  List<Map<String, dynamic>> expenses = [];
  DocumentSnapshot? snapshot;

  void getData() async {
    UserManager userManager = UserManager();
    String? uid;

    uid = await userManager.getUID();

    // Use async-await function to get the data
    final data = await FirebaseFirestore.instance
        .collection("expenses")
        .doc('$uid')
        .collection("expenses")
        .get(); // Get the data

    // Processing data
    List<Map<String, dynamic>> newExpenses = [];
    data.docs.forEach((doc) {
      newExpenses.add(doc.data() as Map<String, dynamic>);
    });

    setState(() {
      expenses = newExpenses; // Update the data list state
    });
  }

  double calculatePercentage(double costs, double totalCosts) {
    return (costs / totalCosts) * 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                final categories = expense['categories'] as List<dynamic>;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: categories.map((category) {
                    final double costs = category['costs'].toDouble();
                    final double totalCosts = expense['costs'].toDouble();

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                    title:
                                        Text('Category ID: ${category['id']}'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Costs: ${category['costs']}'),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount:
                                              category['expenses'].length,
                                          itemBuilder: (context, j) {
                                            final expenseItem =
                                                category['expenses'][j];
                                            return ListTile(
                                              title: Text(
                                                  'Name: ${expenseItem['name']}'),
                                              subtitle: Text(
                                                  'Cost: ${expenseItem['cost']} PLN'),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
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
                                  '${calculatePercentage(costs, totalCosts).toStringAsFixed(1)}%',
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
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                final categories = expense['categories'] as List<dynamic>;

                return Column(
                  children: categories.map((category) {
                    return Column(
                      children: [
                        SizedBox(
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
                                            'Category Name: ${category['name']}'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text('Costs: ${category['costs']}'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
