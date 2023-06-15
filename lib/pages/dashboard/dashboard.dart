import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/helpers/mysaving_nav.dart';
import 'package:mysavingapp/common/utils/mysaving_images.dart';
import 'package:mysavingapp/config/bloc/app_bloc.dart';
import 'package:mysavingapp/config/models/dashboard_model.dart';
import 'package:mysavingapp/config/repository/dashboard_repository.dart';
import 'package:mysavingapp/pages/dashboard/conf/cubit/dashboard_analitycs_cubit.dart';
import 'package:mysavingapp/pages/dashboard/conf/cubit/dashboard_summary_cubit.dart';
import 'package:mysavingapp/pages/dashboard/helpers/dashboard_analitycs.dart';
import 'package:mysavingapp/pages/dashboard/helpers/dashboard_summary.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../config/repository/interfaces/IDashboardRepository.dart';

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
              Gap(20),
              DashboardAnalitycsPage()
            ],
          ),
        ),
      ),
    );
  }
}
