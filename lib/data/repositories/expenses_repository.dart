import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysavingapp/data/repositories/interfaces/IExpensesRepository.dart';
import 'package:mysavingapp/config/services/user_manager.dart';

import '../models/expenses_model.dart';

class ExpensesRepository extends IExpensesRepository {
  final String? uid;
  ExpensesRepository({this.uid});
  String mainCollection = dotenv.env['MAIN_COLLECTION']!;
  String eCollection = dotenv.env['E_COLLECTION']!;
  String eSubCollection = dotenv.env['E_CAT']!;
  Future<void> updateUserData(List<Category> categories) async {
    final CollectionReference expenseCollection =
        FirebaseFirestore.instance.collection(mainCollection);
    List<Map<String, dynamic>> categoriesData = categories.map((category) {
      List<Map<String, dynamic>> expensesData =
          category.expenses!.map((expense) {
        return {
          'name': expense.name,
          'cost': expense.cost,
          'time': expense.expensesTime
        };
      }).toList();

      int totalCosts = category.expenses!.fold(
          0, (int previousValue, expense) => previousValue + expense.cost!);

      category.costs = totalCosts;

      return {
        'id': category.id,
        'name': category.name,
        'url': category.url,
        'costs': totalCosts,
        eCollection: expensesData,
      };
    }).toList();

    // Create a new document in the "expenses" collection with the user's UID as the document ID
    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    CollectionReference userExpensesCol =
        userExpenseDoc.collection(eCollection);

    await userExpensesCol.add({
      'id': uid,
      'costs': categories.fold(
          0, (int previousValue, category) => previousValue + category.costs!),
      eSubCollection: categoriesData,
    });
  }

  @override
  Future<List<Category>> getCategory() {
    throw UnimplementedError();
  }

  @override
  Future<List<Expenses>> getExpenses() async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();
    List<Expenses> expensesList = [];
    final result = await firestore
        .collection(mainCollection)
        .doc(userID)
        .collection(eCollection)
        .get();
    for (var expensesDoc in result.docs) {
      final expensesData = expensesDoc.data();
      final expensesCategories = expensesData[eSubCollection];
      print("Categories: $expensesCategories");

      if (expensesCategories != null) {
        List<Category> categoryList = [];
        for (var categoryData in expensesCategories) {
          List<Expense> expenseList = [];
          for (var expenseData in categoryData[eCollection]) {
            print("Expense: $expenseData");
            Expense expense = Expense.fromJson(expenseData);
            expenseList.add(expense);
          }

          Category category = Category.fromJson(categoryData);
          category.expenses = expenseList;
          categoryList.add(category);
        }

        Expenses userExpenses = Expenses(
          id: int.tryParse(expensesData['id'].toString()),
          costs: expensesData['costs'],
          categories: categoryList,
        );
        expensesList.add(userExpenses);
      }
    }
    return expensesList;
  }

  @override
  Future<void> addExpense(String name, int cost, int categoryId) async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();
    final CollectionReference expenseCollection =
        FirebaseFirestore.instance.collection(mainCollection);
    DocumentReference userExpenseDoc = expenseCollection.doc(userID);
    CollectionReference userExpensesCol =
        userExpenseDoc.collection(eCollection);

    try {
      final categorySnapshot =
          await userExpensesCol.doc(categoryId.toString()).get();
      final categoryData = categorySnapshot.data() as Map<String, dynamic>?;

      if (categoryData != null) {
        List<dynamic> expenses = categoryData[eCollection] ?? [];

        expenses.add({
          'name': name,
          'cost': cost,
        });

        await userExpensesCol.doc(categoryId.toString()).update({
          eCollection: expenses,
        });
      } else {
        // Jeśli kategoria nie istnieje w bazie danych, dodaj ją wraz z nowym wydatkiem
        await userExpensesCol.doc(categoryId.toString()).set({
          eCollection: [
            {'name': name, 'cost': cost},
          ],
        });
      }
    } catch (error, stackTrace) {
      print('Error while adding expense: $error');
      print('Stack trace: $stackTrace');
    }
  }
}
