import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/helpers/profile_nav.dart';
import 'package:mysavingapp/pages/profile/helpers/profile_buttons.dart';
import 'package:mysavingapp/pages/profile/helpers/profile_image.dart';
import 'package:provider/provider.dart';

import '../../common/helpers/mysaving_switch.dart';
import '../../common/utils/mysaving_colors.dart';
import '../../config/services/theme_constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void changeTheme() {
    DarkModeSwitch.toggleDarkMode();
    setState(() {}); // Odświeżenie widoku po zmianie trybu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MySavingColors.defaultBackgroundPage,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileNav(),
              Gap(20),
              ProfileImage(),
              Gap(20),
              MysavingSwitch(
                isSwitchedValue: DarkModeSwitch.isDarkMode,
                onSwitchChanged: (bool isDarkMode) {
                  changeTheme();
                },
              ),
              Gap(20),
              ProfileButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
