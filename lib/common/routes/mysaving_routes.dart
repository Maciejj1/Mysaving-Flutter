import 'package:flutter/material.dart';
import 'package:mysavingapp/pages/dashboard/dashboard.dart';
import 'package:mysavingapp/pages/main_page/main_page.dart';
import 'package:mysavingapp/pages/splash_screen/splash_screen.dart';

import '../../config/bloc/app_bloc.dart';
import '../../pages/auth/login/login.dart';

List<Page<dynamic>> onGeneratedMysavingViewPages(
  AppStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case AppStatus.authenticated:
      return [MainPage.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
