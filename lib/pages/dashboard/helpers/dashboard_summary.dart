import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/config/models/dashboard_model.dart';
import 'package:mysavingapp/pages/dashboard/helpers/widgets/dashboard_summary_row.dart';

import '../../../config/repository/dashboard_repository.dart';
import '../conf/cubit/dashboard_summary_cubit.dart';

class DashboardSummaryPage extends StatelessWidget {
  const DashboardSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardSummaryCubit(dashboardRepository: DashboardRepository())
            ..getSummary(),
      child: summaryBlocBody(),
    );
  }

  Widget summaryBlocBody() {
    return BlocProvider(
      create: (context) =>
          DashboardSummaryCubit(dashboardRepository: DashboardRepository())
            ..getSummary(),
      child: BlocConsumer<DashboardSummaryCubit, DashboardSummaryState>(
        listener: (context, state) {
          if (state is DashboardSummarySuccess) {}
        },
        builder: (context, state) {
          if (state is DashboardSummaryLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is DashboardSummaryError) {
            return const Center(child: Text('Cos poszlo nie tak'));
          }
          if (state is DashboardSummarySuccess) {
            List<DashboardSummary> dashboardSummaryList =
                state.dashboardSummaryList;

            if (dashboardSummaryList.isNotEmpty) {
              int index = 0;
              DashboardSummary dashboardSummary = dashboardSummaryList[index];

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.redAccent),
                    child: Column(children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text('Twoje oszczednosci'),
                          Gap(30),
                          Text('${dashboardSummary.saving}'),
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 30,
                              height: 20,
                              color: Colors.white,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.arrow_drop_down)),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Gap(20),
                  Container(
                    height: 150,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.redAccent),
                    child: Column(children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text('Podsumowanie'),
                          Gap(5),
                          DashboardSummaryRow(
                              titleText: 'Saldo',
                              costs: '${dashboardSummary.saldo}',
                              icon: Icons.abc),
                          DashboardSummaryRow(
                              titleText: 'Oszczędności',
                              costs: '${dashboardSummary.saving}',
                              icon: Icons.account_balance_wallet),
                          DashboardSummaryRow(
                              titleText: 'Wydatki',
                              costs: '${dashboardSummary.expenses}',
                              icon: Icons.access_alarm)
                        ],
                      )),
                    ]),
                  ),
                ],
              );
            } else {
              return Text('No dashboard summary available.');
            }
          }
          return Container();
        },
      ),
    );
  }
}
