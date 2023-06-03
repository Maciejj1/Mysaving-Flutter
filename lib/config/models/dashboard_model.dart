import 'dashboard_analitycs.dart';
import 'dashboard_expenses.dart';
import 'dashboard_summary.dart';

class DashboardModel {
  final int id;
  final List<DashboardSummary> summaries;
  final List<DashboardExpenses> expenses;
  final List<DashboardAnalytics> analytics;

  DashboardModel(
    this.id, {
    required this.summaries,
    required this.expenses,
    required this.analytics,
  });
}
