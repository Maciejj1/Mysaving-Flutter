import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/pages/app_tutorial/mysaving_tutorial.dart';

import '../../common/styles/mysaving_styles.dart';
import '../../common/utils/mysaving_images.dart';

// ignore: must_be_immutable
class WelcomeTutorialScreen extends StatelessWidget {
  WelcomeTutorialScreen({super.key});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WelcomeTutorialScreen());
  }

  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    var msstyles = MySavingStyles(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Gap(180),
            SvgPicture.asset(
              images.mysavingLogo,
            ),
            Gap(100),
            Text(
              'Witaj Jan w MySaving!',
              style: msstyles.mysavingAuthTitleStyle,
            ),
            Gap(30),
            SizedBox(
              width: 350,
              child: Text(
                'Kliknij w przycisk aby zacząć oszczędzać na swoje marzenia!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF202020),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Gap(80),
            Container(
              height: 44.0,
              width: 250,
              decoration: msstyles.mysavingButtonContainerStyles,
              child: ElevatedButton(
                  style: msstyles.mysavingButtonStyles,
                  onPressed: () {
                    Navigator.of(context).push<void>(MySavingTutorial.route());
                  },
                  child: Text('Zacznijmy')),
            ),
          ]),
        ),
      )),
    );
  }
}
