import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/helpers/profile_nav.dart';
import 'package:mysavingapp/pages/profile/helpers/profile_buttons.dart';
import 'package:mysavingapp/pages/profile/helpers/profile_image.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileNav(),
              Gap(20),
              ProfileImage(),
              Gap(20),
              ProfileButtons()
            ],
          ),
        ),
      ),
    );
  }
}
