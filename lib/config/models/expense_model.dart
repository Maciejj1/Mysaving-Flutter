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
