import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:mysavingapp/config/repository/interfaces/IDashboardRepository.dart';
import 'package:intl/intl.dart';
import '../models/dashboard_model.dart';
import '../singleton/user_manager.dart';

class DashboardRepository extends IDashboardRepository {
  final String? uid;

  DashboardRepository({this.uid});

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> updateUserData(List<DashboardModel> dashboards) async {
    List<Map<String, dynamic>> dashboardData = dashboards.map((dashboard) {
      List<Map<String, dynamic>> dashboardSummary =
          dashboard.dashboardSummary!.map((summary) {
        return {
          'id': summary.id,
          'saldo': summary.saldo,
          'saving': summary.saving,
          'expenses': summary.expenses,
        };
      }).toList();

      List<Map<String, dynamic>> dashboardLastExpenses =
          dashboard.dashboardLastExpenses!.map((lastExpenses) {
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
          dashboard.dashboardAnalytics!.map((analitycs) {
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

  @override
  Future<List<DashboardSummary>> getDashboardSummary() async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();
    List<DashboardSummary> dashboardList = [];
    final result = await firestore
        .collection('userData')
        .doc(userID)
        .collection('dashboard')
        .get();
    for (var dashboardDoc in result.docs) {
      final dashboardData = dashboardDoc.data();
      final dashboardSummary =
          dashboardData['dashboards'][0]['dashboardSummary'];

      print('DashboardSummary: $dashboardSummary');

      if (dashboardSummary != null) {
        DashboardSummary dashboardSummaryModel =
            DashboardSummary.fromJson(dashboardSummary);

        dashboardList.add(dashboardSummaryModel);
      }
    }

    return dashboardList;
  }

  @override
  Future<List<DashboardAnalytics>> getDashboardAnalitycs() async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();
    List<DashboardAnalytics> dashboardList = [];
    final result = await firestore
        .collection('userData')
        .doc(userID)
        .collection('dashboard')
        .get();
    for (var dashboardDoc in result.docs) {
      final dashboardData = dashboardDoc.data();
      final dashboardAnalitycs =
          dashboardData['dashboards'][0]['dashboardAnalitycs'];

      print('DashboardAnalitycs: $dashboardAnalitycs');

      if (dashboardAnalitycs != null) {
        List<DashboardAnalitycsDay> summaryList = [];

        for (var dayData in dashboardAnalitycs[0]['summary']) {
          String dayName = dayData['date'];
          DateTime now = DateTime.now();
          int dayIndex = DateFormat('EEE').parse(dayName).weekday;
          DateTime date = now.subtract(Duration(days: now.weekday - dayIndex));
          DashboardAnalitycsDay day = DashboardAnalitycsDay(
            id: dayData['id'],
            saldo: dayData['saldo'],
            saving: dayData['saving'],
            expenses: dayData['expenses'],
            date: date,
          );
          summaryList.add(day);
        }

        DashboardAnalytics dashboardAnalytics = DashboardAnalytics(
          summary: summaryList,
        );

        dashboardList.add(dashboardAnalytics);
      }
    }

    return dashboardList;
  }

  @override
  Future<List<DashboardLastExpenses>> getDashboardExpenses() {
    throw UnimplementedError();
  }
}
