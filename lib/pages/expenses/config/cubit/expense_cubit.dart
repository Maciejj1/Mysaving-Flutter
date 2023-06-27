import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mysavingapp/data/models/expenses_model.dart';
import 'package:mysavingapp/data/repositories/interfaces/IExpensesRepository.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final IExpensesRepository dashboardRepository;

  ExpenseCubit({required this.dashboardRepository}) : super(ExpenseInitial());

  Future<void> getSummary() async {
    emit(ExpenseLoading());

    try {
      final results = await dashboardRepository.getExpenses();
      emit(ExpenseSuccess(expenses: results));
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace.toString());
      emit(ExpenseError(error: 'Something went wrong'));
    }
  }
}
