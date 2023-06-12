import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../config/models/dashboard_model.dart';
import '../../../../config/repository/interfaces/IDashboardRepository.dart';

part 'dashboard_expenses_state.dart';

class DashboardExpensesCubit extends Cubit<DashboardExpensesState> {
  final IDashboardRepository dashboardRepository;

  DashboardExpensesCubit({required this.dashboardRepository})
      : super(DashboardExpensesInitial());

  Future<void> getSummary() async {
    emit(DashboardExpensesLoading());

    try {
      final results = await dashboardRepository.getDashboardExpenses();
      emit(DashboardExpensesSuccess(dashboardExpenses: results));
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace.toString());
      emit(DashboardExpensesError(error: 'Something went wrong'));
    }
  }
}
