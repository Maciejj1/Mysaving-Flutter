import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('expenses');

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
    await userExpenseDoc.set({
      'id': uid,
      'costs': 0,
      'categories': categoriesData,
    });
  }
}
