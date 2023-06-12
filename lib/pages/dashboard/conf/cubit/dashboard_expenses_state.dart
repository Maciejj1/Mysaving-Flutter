part of 'dashboard_expenses_cubit.dart';

abstract class DashboardExpensesState extends Equatable {
  const DashboardExpensesState();

  @override
  List<Object> get props => [];
}

class DashboardExpensesInitial extends DashboardExpensesState {}

class DashboardExpensesLoading extends DashboardExpensesState {}

class DashboardExpensesSuccess extends DashboardExpensesState {
  final List<DashboardLastExpenses> dashboardExpenses;

  DashboardExpensesSuccess({required this.dashboardExpenses});

  @override
  List<Object> get props => [dashboardExpenses];
}

class DashboardExpensesError extends DashboardExpensesState {
  final String error;

  DashboardExpensesError({required this.error});

  @override
  List<Object> get props => [error];
}
