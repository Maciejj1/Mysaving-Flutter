import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mysavingapp/config/models/dashboard_model.dart';
import 'package:mysavingapp/config/repository/dashboard/IDashboardRepository.dart';
import 'package:mysavingapp/config/repository/dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({IDashboardRepository? dashboardRepository})
      : _dashboardRepository = dashboardRepository ?? DashboardRepository(),
        super(DashboardInitial());
  final IDashboardRepository _dashboardRepository;

  Future<void> getDashboard() async {
    emit(DashboardLoading());
    final results = await _dashboardRepository.getAllDashboard();
    emit(DashboardSuccess(dashboardList: results));
  }
}
