import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mysavingapp/config/repository/interfaces/IExpensesRepository.dart';

import '../../../../config/models/expenses_model.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final IExpensesRepository expensesRepository;
  ExpensesCubit({required this.expensesRepository}) : super(ExpensesInitial());

  Future<void> getExpenses() async {
    emit(ExpensesLoading());
    try {
      final result = await expensesRepository.getExpenses();
      emit(ExpensesSuccess(expensesList: result));
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace.toString());
      emit(ExpensesError(error: 'Cos poszlo nie tak'));
    }
  }
}
