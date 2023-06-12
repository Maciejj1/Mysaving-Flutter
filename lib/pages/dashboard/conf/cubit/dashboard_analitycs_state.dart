part of 'dashboard_analitycs_cubit.dart';

abstract class DashboardAnalitycsState extends Equatable {
  const DashboardAnalitycsState();

  @override
  List<Object> get props => [];
}

class DashboardAnalitycsInitial extends DashboardAnalitycsState {}

class DashboardAnalitycsLoading extends DashboardAnalitycsState {}

class DashboardAnalitycsSuccess extends DashboardAnalitycsState {
  final List<DashboardAnalytics> dashboardExpenses;

  DashboardAnalitycsSuccess({required this.dashboardExpenses});

  @override
  List<Object> get props => [dashboardExpenses];
}

class DashboardAnalitycsError extends DashboardAnalitycsState {
  final String error;

  DashboardAnalitycsError({required this.error});

  @override
  List<Object> get props => [error];
}
