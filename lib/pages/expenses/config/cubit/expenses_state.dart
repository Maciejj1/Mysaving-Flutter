part of 'expenses_cubit.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object> get props => [];
}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesSuccess extends ExpensesState {
  final List<Expenses> expensesList;

  ExpensesSuccess({required this.expensesList});

  @override
  List<Object> get props => [expensesList];
}

class ExpensesError extends ExpensesState {
  final String error;

  ExpensesError({required this.error});

  @override
  List<Object> get props => [error];
}
