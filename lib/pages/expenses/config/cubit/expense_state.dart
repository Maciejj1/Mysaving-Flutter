part of 'expense_cubit.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseSuccess extends ExpenseState {
  final List<Expenses> expenses;

  ExpenseSuccess({required this.expenses});

  @override
  List<Object> get props => [expenses];
}

class ExpenseError extends ExpenseState {
  final String error;

  ExpenseError({required this.error});

  @override
  List<Object> get props => [error];
}
