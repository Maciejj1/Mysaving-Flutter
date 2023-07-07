import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/common/utils/mysaving_images.dart';
import 'package:mysavingapp/pages/auth/login/login.dart';

import '../../common/styles/mysaving_styles.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  static Page<void> page() => MaterialPage<void>(child: SplashScreen());
  SplashScreen({super.key});
  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    var msstyles = MySavingStyles(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Gap(30),
            SvgPicture.asset(
              images.mysavingLogo,
            ),
            Gap(30),
            Text(
              'Zacznijmy',
              style: msstyles.mysavingAuthTitleStyle,
            ),
            Gap(30),
            SizedBox(
              width: 250,
              child: Text(
                'Zaloguj się lub zarejstruj i zacznij oszczędzać na swoje marzenia',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MySavingColors.defaultDarkText,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Gap(50),
            Image.asset(images.splashScreen),
            Gap(80),
            Container(
              height: 44.0,
              width: 250,
              decoration: msstyles.mysavingButtonContainerStyles,
              child: ElevatedButton(
                  style: msstyles.mysavingButtonStyles,
                  onPressed: () {
                    Navigator.of(context).push<void>(LoginScreen.route());
                  },
                  child: Text('Zacznijmy')),
            ),
          ]),
        ),
      )),
    );
  }
}
