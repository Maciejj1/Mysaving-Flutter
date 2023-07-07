import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mysavingapp/data/models/expenses_model.dart';
import 'package:mysavingapp/data/repositories/interfaces/IExpensesRepository.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final IExpensesRepository expensesRepository;

  ExpenseCubit({required this.expensesRepository}) : super(ExpenseInitial());

  Future<void> getSummary() async {
    emit(ExpenseLoading());

    try {
      final results = await expensesRepository.getExpenses();
      emit(ExpenseSuccess(expenses: results));
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace.toString());
      emit(ExpenseError(error: 'Something went wrong'));
    }
  }

  Future<void> addExpense(String name, int cost, int categoryId) async {
    emit(ExpenseLoading());

    try {
      await expensesRepository.addExpense(name, cost, categoryId);
      emit(ExpenseAddSuccess());
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace.toString());
      emit(ExpenseError(error: 'Something went wrong'));
    }
  }
}
