import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/dashboard_model.dart';

class DashboardRepository {
  final String? uid;

  DashboardRepository({this.uid});

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> updateUserData(List<DashboardModel> dashboards) async {
    List<Map<String, dynamic>> dashboardData = dashboards.map((dashboard) {
      List<Map<String, dynamic>> dashboardSummary =
          dashboard.dashboardSummary.map((summary) {
        return {
          'id': summary.id,
          'saldo': summary.saldo,
          'saving': summary.saving,
          'expenses': summary.expenses,
        };
      }).toList();

      List<Map<String, dynamic>> dashboardLastExpenses =
          dashboard.dashboardLastExpenses.map((lastExpenses) {
        return {
          'categories': lastExpenses.categories.map((category) {
            return {
              'id': category.id,
              'name': category.name,
              'url': category.url,
              'expenses': category.expenses.map((expense) {
                return {
                  'name': expense.name,
                  'cost': expense.cost,
                };
              }).toList(),
              'costs': category.costs,
            };
          }).toList(),
        };
      }).toList();
      List<Map<String, dynamic>> dashboardAnalitycs =
          dashboard.dashboardAnalytics.map((analitycs) {
        return {
          'summary': analitycs.summary.map((anali) {
            return {
              'id': anali.id,
              'saldo': anali.saldo,
              'expenses': anali.expenses,
              'saving': anali.saving,
              'date': anali.weekdayName,
            };
          }).toList(),
        };
      }).toList();

      return {
        'id': dashboard.id,
        'dashboardSummary': dashboardSummary,
        'dashboardLastExpenses': dashboardLastExpenses,
        'dashboardAnalitycs': dashboardAnalitycs,
      };
    }).toList();

    // Tworzymy nowy dokument w kolekcji "expenses" z UID użytkownika jako ID dokumentu
    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    CollectionReference userDashboardCol =
        userExpenseDoc.collection('dashboard');

    await userDashboardCol.add({
      'dashboards': dashboardData,
    });
  }
}
