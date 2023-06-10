import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mysavingapp/config/models/dashboard_model.dart';

import '../../../../config/repository/dashboard/IDashboardRepository.dart';
import '../../../../config/repository/dashboard_repository.dart';

part 'dashboard_summary_state.dart';

class DashboardSummaryCubit extends Cubit<DashboardSummaryState> {
  DashboardSummaryCubit({IDashboardRepository? dashboardRepository})
      : _dashboardRepository = dashboardRepository ?? DashboardRepository(),
        super(DashboardSummaryInitial());
  final IDashboardRepository _dashboardRepository;

  Future<void> getSummary() async {
    emit(DashboardSummaryLoading());
    final results = await _dashboardRepository.getDashboardSummary();
    emit(DashboardSummarySuccess(dashboardSummaryList: results));
  }
}
