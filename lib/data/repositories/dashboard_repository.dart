import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysavingapp/data/repositories/interfaces/IDashboardRepository.dart';
import 'package:intl/intl.dart';
import '../models/dashboard_model.dart';
import '../../config/services/user_manager.dart';

class DashboardRepository extends IDashboardRepository {
  final String? uid;

  DashboardRepository({this.uid});
  String mainCollection = dotenv.env['MAIN_COLLECTION']!;
  String dCollection = dotenv.env['D_COLLECTION']!;
  String dSubCollection = dotenv.env['D_SUBCOLLECTION']!;
  String dSummary = dotenv.env['D_SUMMARY']!;
  String dAnalitycs = dotenv.env['D_ANALITYCS']!;

  Future<void> updateUserData(List<DashboardModel> dashboards) async {
    final CollectionReference expenseCollection =
        FirebaseFirestore.instance.collection(mainCollection);
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

      List<Map<String, dynamic>> dashboardAnalitycs =
          dashboard.dashboardAnalytics!.map((analitycs) {
        return {
          'summary': analitycs.summary.map((anali) {
            return {
              'id': anali.id,
              'saldo': anali.saldo,
              'expenses': anali.expenses,
              'saving': anali.saving,
              'date': anali.date.toString(),
            };
          }).toList(),
        };
      }).toList();

      return {
        'id': dashboard.id,
        'dashboardSummary': dashboardSummary,
        'dashboardAnalitycs': dashboardAnalitycs,
      };
    }).toList();

    // Tworzymy nowy dokument w kolekcji "dashboard" z UID użytkownika jako ID dokumentu
    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    CollectionReference userDashboardCol =
        userExpenseDoc.collection(dCollection);

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
        .collection(mainCollection)
        .doc(userID)
        .collection(dCollection)
        .get();
    for (var dashboardDoc in result.docs) {
      final dashboardData = dashboardDoc.data();
      final dashboardSummary = dashboardData[dSubCollection][0][dSummary];

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
        .collection(mainCollection)
        .doc(userID)
        .collection(dCollection)
        .get();
    for (var dashboardDoc in result.docs) {
      final dashboardData = dashboardDoc.data();
      final dashboardAnalitycs = dashboardData[dSubCollection][0][dAnalitycs];

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
            date: date.toString(),
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
}
