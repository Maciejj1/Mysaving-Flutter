import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysavingapp/data/models/dashboard_model.dart';

abstract class IDashboardRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<DashboardAnalytics>> getDashboardAnalitycs();
  // Future<List<DashboardLastExpenses>> getDashboardExpenses();
  Future<List<DashboardSummary>> getDashboardSummary();
}
