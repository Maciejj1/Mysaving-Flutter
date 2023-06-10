part of 'dashboard_cubit.dart';

// enum DashboardStatus { initial, loading, success, error, refres }

// @immutable
// class DashboardState extends Equatable {
//   final DashboardStatus status;
//   final List dashboardList;
//   const DashboardState({required this.status, required this.dashboardList});

//   factory DashboardState.initial() {
//     return const DashboardState(
//         dashboardList: [], status: DashboardStatus.initial);
//   }

//   DashboardState copyWith({List? dashboardList, DashboardStatus? status}) {
//     return DashboardState(
//         status: status ?? this.status,
//         dashboardList: dashboardList ?? this.dashboardList);
//   }

//   @override
//   List<Object> get props => [dashboardList, status];
// }
abstract class DashboardState {
  DashboardState();
}

class DashboardInitial extends DashboardState {
  DashboardInitial();
}

class DashboardLoading extends DashboardState {
  DashboardLoading();
}

class DashboardSuccess extends DashboardState {
  List<DashboardModel>? dashboardList;
  DashboardSuccess({required this.dashboardList});
}

class DashboardError extends DashboardState {
  String? error;
  DashboardError({required this.error});
}

class DashboardRefres extends DashboardState {
  List<DashboardModel>? dashboardList;
  DashboardRefres({required this.dashboardList});
}
