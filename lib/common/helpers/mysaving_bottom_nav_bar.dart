// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mysavingapp/common/theme/bloc/theme_bloc.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/common/theme/theme_constants.dart';

class MySavingBottomNav extends StatefulWidget {
  const MySavingBottomNav(
      {super.key, required this.selectedIndex, required this.onTap});
  final int selectedIndex;
  final Function(int) onTap;
  @override
  State<MySavingBottomNav> createState() => _MySavingBottomNavState();
}

class _MySavingBottomNavState extends State<MySavingBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DarkModeBloc(),
      child: Container(
        decoration: BoxDecoration(
          color: MySavingColors.defaultCategories,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: DarkModeSwitch.isDarkMode
                  ? Colors.white.withOpacity(.1)
                  : Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: MySavingColors.defaultBackgroundPage,
              hoverColor: MySavingColors.defaultDarkText,
              gap: 8,
              activeColor: MySavingColors.defaultExpensesText,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: DarkModeSwitch.isDarkMode
                  ? Colors.black12
                  : Colors.grey[100]!,
              color: MySavingColors.defaultDarkText,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.moneyBill,
                  text: 'Expenses',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                widget.onTap(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
