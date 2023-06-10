import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:mysavingapp/config/repository/dashboard/IDashboardRepository.dart';

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

  Future<List<DashboardModel>> getDashboard() async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();
    final userDashboardDoc = expenseCollection.doc(userID);
    final CollectionReference userDahboardPath =
        userDashboardDoc.collection('dashboard');

    try {
      QuerySnapshot snapshot = await userDahboardPath.get();
      if (snapshot.docs.isNotEmpty) {
        List<DashboardModel> dashboardList = snapshot.docs
            .map((DocumentSnapshot document) => DashboardModel.fromJson(
                document.data() as Map<String, dynamic>))
            .toList();
        return dashboardList;
      } else {
        return [];
      }
    } catch (e, stacktrace) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<DashboardModel>> getAllDashboard() async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();
    final userDashboardDoc = expenseCollection.doc(userID);
    final CollectionReference userDahboardPath =
        userDashboardDoc.collection('dashboard');
    List<DashboardModel> dashboardList = [];
    final result = await firestore
        .collection('userData')
        .doc(userID)
        .collection('dashboard')
        .get();
    for (var snapshot in result.docs) {
      DashboardModel dashboardModel = DashboardModel.fromJson(snapshot.data());
      dashboardModel.id = snapshot.id;
      dashboardList.add(dashboardModel);
    }
    return dashboardList;
  }

  @override
  Future<List<DashboardSummary>> getDashboardSummary() async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();
    final userDashboardDoc = expenseCollection.doc(userID);
    final CollectionReference userDahboardPath =
        userDashboardDoc.collection('dashboard');
    List<DashboardSummary> dashboardList = [];
    final result = await firestore
        .collection('userData')
        .doc(userID)
        .collection('dashboard')
        .doc(uid)
        .get();

    if (result.exists) {
      final data = result.data();
      if (data != null) {
        final dashboardAnalyticsList =
            data['dashboardAnalytics'] as List<dynamic>;
        final dashboardLastExpensesList =
            data['dashboardLastExpenses'] as List<dynamic>;
        final dashboardSummaryList = data['dashboardSummary'] as List<dynamic>;

        // Use or process the lists according to your needs
        print(dashboardAnalyticsList);
        print(dashboardLastExpensesList);
        print(dashboardSummaryList);
      }
    }

    return dashboardList;
  }
}
