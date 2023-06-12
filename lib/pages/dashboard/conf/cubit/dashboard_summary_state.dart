part of 'dashboard_summary_cubit.dart';

abstract class DashboardSummaryState extends Equatable {
  const DashboardSummaryState();

  @override
  List<Object> get props => [];
}

class DashboardSummaryInitial extends DashboardSummaryState {}

class DashboardSummaryLoading extends DashboardSummaryState {}

class DashboardSummarySuccess extends DashboardSummaryState {
  final List<DashboardSummary> dashboardSummaryList;

  DashboardSummarySuccess({required this.dashboardSummaryList});

  @override
  List<Object> get props => [dashboardSummaryList];
}

class DashboardSummaryError extends DashboardSummaryState {
  final String error;

  DashboardSummaryError({required this.error});

  @override
  List<Object> get props => [error];
}
