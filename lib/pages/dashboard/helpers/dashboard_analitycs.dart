import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/config/repository/dashboard_repository.dart';
import 'package:mysavingapp/pages/dashboard/conf/cubit/dashboard_analitycs_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../config/models/dashboard_model.dart';

class DashboardAnalitycsPage extends StatelessWidget {
  const DashboardAnalitycsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardAnalitycsCubit(dashboardRepository: DashboardRepository())
            ..getSummary(),
      child: analitycsBloc(),
    );
  }

  Widget analitycsBloc() {
    return BlocConsumer<DashboardAnalitycsCubit, DashboardAnalitycsState>(
      listener: (context, state) {
        if (state is DashboardAnalitycsSuccess) {}
      },
      builder: (context, state) {
        if (state is DashboardAnalitycsLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is DashboardAnalitycsError) {
          return const Center(child: Text('Cos poszlo nie tak'));
        }
        if (state is DashboardAnalitycsSuccess) {
          List<DashboardAnalytics> dashboardExpenses = state.dashboardExpenses;

          if (dashboardExpenses.isNotEmpty) {
            List<DashboardAnalitycsDay> last7DaysExpenses = dashboardExpenses
                .expand((analytics) => analytics.summary)
                .take(7)
                .toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('My Analysis'),
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF444FFF)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('This week'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      ColumnSeries<DashboardAnalitycsDay, String>(
                        dataSource: last7DaysExpenses,
                        xValueMapper: (DashboardAnalitycsDay day, _) =>
                            day.date.toString(),
                        yValueMapper: (DashboardAnalitycsDay day, _) =>
                            day.expenses,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Text('No analytics data available.');
          }
        }
        return Container();
      },
    );
  }
}
