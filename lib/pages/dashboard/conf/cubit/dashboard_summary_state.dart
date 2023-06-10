part of 'dashboard_summary_cubit.dart';

abstract class DashboardSummaryState {
  DashboardSummaryState();
}

class DashboardSummaryInitial extends DashboardSummaryState {
  DashboardSummaryInitial();
}

class DashboardSummaryLoading extends DashboardSummaryState {
  DashboardSummaryLoading();
}

class DashboardSummarySuccess extends DashboardSummaryState {
  List<DashboardSummary>? dashboardSummaryList;
  DashboardSummarySuccess({required this.dashboardSummaryList});
}

class DashboardSummaryError extends DashboardSummaryState {
  String? error;
  DashboardSummaryError({required this.error});
}

class DashboardSummaryRefres extends DashboardSummaryState {
  List<DashboardSummary>? dashboardSummaryList;
  DashboardSummaryRefres({required this.dashboardSummaryList});
}
