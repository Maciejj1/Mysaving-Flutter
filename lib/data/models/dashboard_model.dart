import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardSummary {
  int? id;
  int? saldo;
  int? saving;
  int? expenses;

  DashboardSummary({
    required this.id,
    required this.saldo,
    required this.saving,
    required this.expenses,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saldo': saldo,
      'saving': saving,
      'expenses': expenses,
    };
  }

  DashboardSummary.fromJson(List<dynamic> json) {
    id = json[0]['id'] as int;
    saldo = json[0]['saldo'] as int;
    expenses = json[0]['expenses'] as int;
    saving = json[0]['saving'] as int;
  }
}

class DashboardAnalytics {
  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('expenses');
  List<DashboardAnalitycsDay> summary;

  DashboardAnalytics({required this.summary}) {}

  int calculateTotalExpenses(DateTime day) {
    int total = 0;

    return total;
  }

  int calculateSaldo(DateTime day) {
    return 0;
  }

  int calculateSaving(DateTime day) {
    return 0;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Map<String, dynamic> toMap() {
    return {
      'summary': summary.map((day) => day.toMap()).toList(),
    };
  }
}

class DashboardAnalitycsDay {
  int id;
  int saldo;
  int saving;
  int expenses;
  String date;

  DashboardAnalitycsDay({
    required this.id,
    required this.saldo,
    required this.saving,
    required this.expenses,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saldo': saldo,
      'saving': saving,
      'expenses': expenses,
      'date': date,
    };
  }
}

class DashboardModel {
  String? id;
  List<DashboardAnalytics>? dashboardAnalytics;
  List<DashboardSummary>? dashboardSummary;

  DashboardModel({
    required this.id,
    required this.dashboardAnalytics,
    required this.dashboardSummary,
  });
  DashboardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dashboardAnalytics = json['dashboardAnalytics'];
    dashboardSummary = json['dashboardSummary'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dashboardAnalytics':
          dashboardAnalytics!.map((analytics) => analytics.toMap()).toList(),
      'dashboardSummary':
          dashboardSummary!.map((summary) => summary.toMap()).toList(),
    };
  }
}
