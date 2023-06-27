import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 44.0,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.transparent),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 3, color: MySavingColors.defaultExpensesText),
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              onPressed: () {},
              icon: Icon(
                Icons.save,
                color: MySavingColors.defaultExpensesText,
              ),
              label: Text(
                'Analitycs',
                style: TextStyle(color: MySavingColors.defaultDarkText),
              )),
        ),
        Gap(20),
        Container(
          height: 44.0,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 3, color: MySavingColors.defaultExpensesText),
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              onPressed: () {},
              icon: Icon(
                Icons.save,
                color: MySavingColors.defaultExpensesText,
              ),
              label: Text(
                'Last Month',
                style: TextStyle(color: MySavingColors.defaultDarkText),
              )),
        ),
      ],
    );
  }
}
