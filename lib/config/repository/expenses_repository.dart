import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysavingapp/config/repository/interfaces/IExpensesRepository.dart';
import 'package:mysavingapp/config/singleton/user_manager.dart';

import '../models/expenses_model.dart';

class ExpensesRepository extends IExpensesRepository {
  final String? uid;
  ExpensesRepository({this.uid});

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> updateUserData(List<Category> categories) async {
    List<Map<String, dynamic>> categoriesData = categories.map((category) {
      List<Map<String, dynamic>> expensesData =
          category.expenses.map((expense) {
        return {
          'name': expense.name,
          'cost': expense.cost,
        };
      }).toList();

      int totalCosts = category.expenses.fold(
          0, (int previousValue, expense) => previousValue + expense.cost);

      category.costs = totalCosts;

      return {
        'id': category.id,
        'name': category.name,
        'url': category.url,
        'costs': totalCosts,
        'expenses': expensesData,
      };
    }).toList();

    // Create a new document in the "expenses" collection with the user's UID as the document ID
    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    CollectionReference userExpensesCol = userExpenseDoc.collection('expenses');

    await userExpensesCol.add({
      'id': uid,
      'costs': categories.fold(
          0, (int previousValue, category) => previousValue + category.costs),
      'categories': categoriesData,
    });
  }

  @override
  Future<List<Category>> getCategory() {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Expenses>> getExpenses() async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();
    List<Expenses> expensesList = [];
    final result = await firestore
        .collection('userData')
        .doc(userID)
        .collection('expenses')
        .get();
    for (var expensesDoc in result.docs) {
      final expensesData = expensesDoc.data();
      final expensesCategories = expensesData['categories'];
      print("Categories: $expensesCategories");

      if (expensesCategories != null) {
        List<Category> categoryList = [];
        int id = int.parse(expensesData['id']);
        int costs = int.parse(expensesData['costs']);
        for (var categoryData in expensesCategories) {
          String categoryName = categoryData['name'];
          int costs = int.parse(categoryData['costs']);
          String url = categoryData['url'];
          int id = int.parse(categoryData['id']);

          Category category = Category(
              id: id,
              name: categoryName,
              url: url,
              costs: costs,
              expenses: categoryData['expenses']);
          categoryList.add(category);
        }

        Expenses userExpenses =
            Expenses(id: id, costs: costs, categories: categoryList);
        expensesList.add(userExpenses);
      }
    }
    return expensesList;
  }
}
