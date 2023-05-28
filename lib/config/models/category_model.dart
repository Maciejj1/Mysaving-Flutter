import 'expense_model.dart';

class Category {
  int id;
  String name;
  String url;
  int costs;
  List<Expense> expenses;

  Category(
      {required this.id,
      required this.name,
      required this.url,
      required this.costs,
      required this.expenses});
}
