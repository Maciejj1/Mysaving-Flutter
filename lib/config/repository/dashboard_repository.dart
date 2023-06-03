import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dashboard_expenses.dart';
import '../models/dashboard_model.dart';
import '../models/dashboard_summary.dart';

class DashboardRepository {
  final String? uid;
  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('expenses');

  DashboardRepository({this.uid});

  Future<void> updateUserData(DashboardModel dashboard) async {
    List<Map<String, dynamic>> summariesData =
        dashboard.summaries.map((summary) {
      return {
        'name': summary.name,
        'saldo': summary.saldo,
        'oszczednosci': summary.oszczednosci,
        'wydatki': summary.wydatki,
      };
    }).toList();

    List<Map<String, dynamic>> expensesData = dashboard.expenses.map((expense) {
      return {
        'id': expense.id,
        'totalOszczednosci': expense.totalOszczednosci,
      };
    }).toList();

    List<Map<String, dynamic>> analyticsData =
        dashboard.analytics.map((analytics) {
      return {
        'id': analytics.id,
        'weeklyExpenses': analytics.weeklyExpenses,
      };
    }).toList();

    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    await userExpenseDoc.set({
      'id': uid,
      'summaries': summariesData,
      'expenses': expensesData,
      'analytics': analyticsData,
    });
  }
}
