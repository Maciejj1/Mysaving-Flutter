import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../common/utils/mysaving_colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key, required this.buttonText, required this.buttonMethod});
  final String buttonText;
  final Function buttonMethod;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MySavingColors.defaultBlueButton),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          onPressed: () {
            buttonMethod();
          },
          child: Text(buttonText)),
    );
  }
}
