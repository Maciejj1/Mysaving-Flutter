import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';

import '../../../common/styles/mysaving_styles.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var msstyles = MySavingStyles(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 44.0,
          width: 150,
          decoration: msstyles.mysavingDashboardButtonsContainerStyle,
          child: ElevatedButton.icon(
              style: msstyles.mysavingDashboardButtonsButtonStyle,
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
          decoration: msstyles.mysavingDashboardButtonsContainerStyle,
          child: ElevatedButton.icon(
              style: msstyles.mysavingDashboardButtonsButtonStyle,
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
