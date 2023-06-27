import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/expenses_model.dart';

abstract class IExpensesRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Expenses>> getExpenses();
  Future<List<Category>> getCategory();
}
