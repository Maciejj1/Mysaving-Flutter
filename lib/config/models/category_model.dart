import 'expense_model.dart';

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
}
