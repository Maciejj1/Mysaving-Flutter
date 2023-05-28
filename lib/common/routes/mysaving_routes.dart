import 'package:flutter/material.dart';
import 'package:mysavingapp/pages/dashboard/dashboard.dart';

import '../../config/bloc/app_bloc.dart';
import '../../pages/auth/login/login.dart';

List<Page<dynamic>> onGeneratedMysavingViewPages(
  AppStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case AppStatus.authenticated:
      return [Dashboard.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
