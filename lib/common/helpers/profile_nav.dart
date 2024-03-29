import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/common/theme/bloc/theme_bloc.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';

class ProfileNav extends StatelessWidget {
  const ProfileNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DarkModeBloc(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: MySavingColors.defaultDarkText,
                ))
          ],
        ),
      ),
    );
  }
}
