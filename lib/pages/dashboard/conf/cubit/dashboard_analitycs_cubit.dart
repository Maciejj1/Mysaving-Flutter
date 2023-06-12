import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../config/models/dashboard_model.dart';
import '../../../../config/repository/interfaces/IDashboardRepository.dart';

part 'dashboard_analitycs_state.dart';

class DashboardAnalitycsCubit extends Cubit<DashboardAnalitycsState> {
  final IDashboardRepository dashboardRepository;

  DashboardAnalitycsCubit({required this.dashboardRepository})
      : super(DashboardAnalitycsInitial());

  Future<void> getSummary() async {
    emit(DashboardAnalitycsLoading());

    try {
      final results = await dashboardRepository.getDashboardAnalitycs();
      emit(DashboardAnalitycsSuccess(dashboardExpenses: results));
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace.toString());
      emit(DashboardAnalitycsError(error: 'Something went wrong'));
    }
  }
}
