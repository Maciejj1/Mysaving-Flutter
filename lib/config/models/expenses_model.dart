import 'package:flutter/foundation.dart';

class Expenses {
  int id;
  int costs;
  List<Category> categories;

  Expenses({required this.id, required this.costs, required this.categories});
}

class Expense {
  String name;
  int cost;

  Expense({required this.name, required this.cost});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cost': cost,
    };
  }
}

class Category {
  int id;
  String name;
  String url;
  int costs;
  List<Expense> expenses;

  Category({
    required this.id,
    required this.name,
    required this.url,
    required this.costs,
    required this.expenses,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'costs': costs,
      'expenses': expenses.map((expense) => expense.toMap()).toList(),
    };
  }

  // Category.fromJson(List<dynamic> json) {
  //   id = json[0]['id'] as int;
  //   name = json[0]['name'];
  //   url = json[0]['url'];
  //   costs = json[0]['costs'];
  //   expenses = json[0]['expenses'];
  // }
}
