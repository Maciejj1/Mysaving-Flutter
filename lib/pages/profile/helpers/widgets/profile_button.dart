import 'package:flutter/material.dart';

import '../../../../common/styles/mysaving_styles.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton(
      {super.key, required this.buttonText, required this.buttonMethod});
  final String buttonText;
  final Function buttonMethod;

  @override
  Widget build(BuildContext context) {
    var msstyles = MySavingStyles(context);
    return Container(
      height: 44,
      width: 300,
      decoration: msstyles.mysavingButtonContainerStyles,
      child: ElevatedButton(
          style: msstyles.mysavingButtonStyles,
          onPressed: () {
            buttonMethod();
          },
          child: Text(buttonText)),
    );
  }
}
