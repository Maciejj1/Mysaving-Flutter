import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mysavingapp/config/models/dashboard_model.dart';

abstract class IDashboardRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<DashboardModel>> getAllDashboard();
  Future<List<DashboardSummary>> getDashboardSummary();
}
