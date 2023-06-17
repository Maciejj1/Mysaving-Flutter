import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/config/models/dashboard_model.dart';
import 'package:mysavingapp/pages/dashboard/helpers/widgets/dashboard_currency_picker.dart';
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
                    height: 170,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MySavingColors.defaultBlueButton),
                    child: Column(children: [
                      Expanded(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Twoje oszczednosci',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Gap(30),
                          Text(
                            '${dashboardSummary.saving} PLN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 49,
                              child: DashboardCurrencyPicker(),
                            ),
                          )
                        ],
                      )),
                    ]),
                  ),
                  Gap(20),
                  Container(
                    height: 170,
                    width: 180,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(children: [
                      Expanded(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Podsumowanie',
                                  style: TextStyle(
                                      color: Color(0xFFC0C0C0), fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  DashboardSummaryRow(
                                    titleText: 'Saldo',
                                    costs: '${dashboardSummary.saldo}',
                                    icon: Icons.abc,
                                    iconColor: MySavingColors.defaultBlueButton,
                                    textcolor: MySavingColors.defaultBlueButton,
                                  ),
                                  DashboardSummaryRow(
                                    titleText: 'Oszczędności',
                                    costs: '${dashboardSummary.saving}',
                                    icon: Icons.account_balance_wallet,
                                    iconColor: MySavingColors.defaultGreen,
                                    textcolor: MySavingColors.defaultGreen,
                                  ),
                                  DashboardSummaryRow(
                                    titleText: 'Wydatki',
                                    costs: '${dashboardSummary.expenses}',
                                    icon: Icons.access_alarm,
                                    iconColor: MySavingColors.defaultRed,
                                    textcolor: MySavingColors.defaultRed,
                                  )
                                ],
                              ))
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
