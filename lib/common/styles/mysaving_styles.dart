import 'package:flutter/material.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';

class MySavingStyles {
  late BuildContext _context;
  late MySavingColors mySavingColors;
  MySavingStyles(BuildContext context) {
    _context = context;
  }
  void init(BuildContext context) {
    _context = context;
  }

  BoxDecoration get referenceContainerStyle => BoxDecoration(
      border: Border.all(color: MySavingColors.defaultBlueButton),
      borderRadius: BorderRadius.circular(15));
  // TextStyle get referenceTextStyle => TextStyle(
  //       color: paidworkColors.defaultGreyText,
  //       fontSize: 15,
  //     );
  // Icon get referenceIcon => Icon(
  //       PaidworkIcons.paidwork_icon_arrow_right,
  //       color: paidworkColors.defaultGreyText,
  //       size: 17,
  //     );
  ButtonStyle get notifyButton => ElevatedButton.styleFrom(
        //backgroundColor: paidworkColors.defaultSettingsSaveButton,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      );
}
