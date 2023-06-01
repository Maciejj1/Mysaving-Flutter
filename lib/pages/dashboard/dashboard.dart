import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mysavingapp/common/utils/mysaving_images.dart';
import 'package:mysavingapp/config/bloc/app_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static Page<void> page() => const MaterialPage<void>(child: Dashboard());
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Hej maciej"),
            Image.asset(images.splashScreen),
            SvgPicture.asset(images.splashScreen),
            ElevatedButton(
                onPressed: () {
                  context.read<AppBloc>().add(AppLogoutRequested());
                },
                child: Text('Wyloguj'))
          ],
        ),
      )),
    );
  }
}
