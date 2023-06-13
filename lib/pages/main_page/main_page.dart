import 'package:flutter/material.dart';
import 'package:mysavingapp/common/helpers/mysaving_bottom_nav_bar.dart';
import 'package:mysavingapp/pages/expenses/expenses.dart';
import 'package:mysavingapp/pages/profile/profile.dart';

import '../dashboard/dashboard.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: MainPage());
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    ExpensesScreen(),
    Profile()
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: MySavingBottomNav(
        onTap: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
