import '../models/category_model.dart';
import '../models/expense_model.dart';

class CategoriesList {
  static final CategoriesList instance = CategoriesList._privateConstructor();

  CategoriesList._privateConstructor();

  List<Category> categories = [
    Category(
      id: 1,
      name: 'Home',
      url: 'https://example.com/home',
      expenses: [
        Expense(name: 'Rent', cost: 1000),
        Expense(name: 'Utilities', cost: 200),
      ],
      costs: 0,
    ),
    Category(
      id: 2,
      name: 'Food',
      url: 'https://example.com/home',
      expenses: [
        Expense(name: 'Rent', cost: 100),
        Expense(name: 'Utilities', cost: 200),
      ],
      costs: 0,
    ),
    Category(
      id: 3,
      name: 'Addictions',
      url: 'https://example.com/home',
      expenses: [
        Expense(name: 'Rent', cost: 300),
        Expense(name: 'Utilities', cost: 100),
      ],
      costs: 0,
    ),
    Category(
      id: 4,
      name: 'Events',
      url: 'https://example.com/home',
      expenses: [
        Expense(name: 'Rent', cost: 10),
        Expense(name: 'Utilities', cost: 680),
      ],
      costs: 0,
    ),
    Category(
      id: 5,
      name: 'Charges',
      url: 'https://example.com/home',
      expenses: [
        Expense(name: 'Rent', cost: 311),
        Expense(name: 'Utilities', cost: 420),
      ],
      costs: 0,
    ),
    // Add the remaining categories and expenses here
  ];
}
