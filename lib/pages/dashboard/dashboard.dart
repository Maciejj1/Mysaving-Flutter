import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/helpers/mysaving_nav.dart';
import 'package:mysavingapp/pages/dashboard/helpers/dashboard_analitycs.dart';
import 'package:mysavingapp/pages/dashboard/helpers/dashboard_buttons.dart';
import 'package:mysavingapp/pages/dashboard/helpers/dashboard_expenses.dart';
import 'package:mysavingapp/pages/dashboard/helpers/dashboard_summary.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static Page<void> page() => const MaterialPage<void>(child: Dashboard());
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MySavingUpNav(),
              Gap(20),
              DashboardSummaryPage(),
              Gap(30),
              DashboardButtons(),
              Gap(30),
              DashboardAnalitycsPage(),
              Gap(40),
              DashboardExpenses()
            ],
          ),
        ),
      ),
    );
  }
}
