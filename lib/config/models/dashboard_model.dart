import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'expenses_model.dart';

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

  DashboardAnalytics({required this.summary}) {
    DateTime now = DateTime.now();

    // summary = List.generate(7, (index) {
    //   DateTime day = now.add(Duration(days: index));
    //   return DashboardAnalitycsDay(
    //     id: index + 1,
    //     saldo: calculateSaldo(day),
    //     saving: calculateSaving(day),
    //     expenses: calculateTotalExpenses(day),
    //     date: day,
    //   );
    // });
  }

  int calculateTotalExpenses(DateTime day) {
    int total = 0;

    return total;
  }

  int calculateSaldo(DateTime day) {
    // Implement your logic to calculate saldo for the given day
    // You can use expenses list or any other data to calculate saldo
    return 0;
  }

  int calculateSaving(DateTime day) {
    // Implement your logic to calculate saving for the given day
    // You can use expenses list or any other data to calculate saving
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
  DateTime date;

  DashboardAnalitycsDay({
    required this.id,
    required this.saldo,
    required this.saving,
    required this.expenses,
    required this.date,
  });
  String get weekdayName {
    return DateFormat.E()
        .format(date); // Get the weekday name (e.g., Mon, Tue, Wed)
  }

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

class DashboardLastExpenses {
  List<Category> categories;

  DashboardLastExpenses({
    required this.categories,
  });

  List<Expense> getAllExpenses() {
    List<Expense> allExpenses = [];

    for (Category category in categories) {
      allExpenses.addAll(category.expenses);
    }

    return allExpenses;
  }

  int calculateTotalExpenses() {
    int total = 0;

    List<Expense> allExpenses = getAllExpenses();

    for (Expense expense in allExpenses) {
      total += expense.cost;
    }

    return total;
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories.map((category) => category.toMap()).toList(),
    };
  }
}

class DashboardModel {
  String? id;
  List<DashboardAnalytics>? dashboardAnalytics;
  List<DashboardSummary>? dashboardSummary;
  List<DashboardLastExpenses>? dashboardLastExpenses;

  DashboardModel({
    required this.id,
    required this.dashboardAnalytics,
    required this.dashboardSummary,
    required this.dashboardLastExpenses,
  });
  DashboardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dashboardAnalytics = json['dashboardAnalytics'];
    dashboardSummary = json['dashboardSummary'];
    dashboardLastExpenses = json['dashboardLastExpenses'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dashboardAnalytics':
          dashboardAnalytics!.map((analytics) => analytics.toMap()).toList(),
      'dashboardSummary':
          dashboardSummary!.map((summary) => summary.toMap()).toList(),
      'dashboardLastExpenses': dashboardLastExpenses!
          .map((lastExpenses) => lastExpenses.toMap())
          .toList(),
    };
  }
}
