import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/data/repositories/profile_repository.dart';
import 'package:mysavingapp/pages/profile/config/cubit/profile_cubit.dart';

import '../utils/mysaving_images.dart';

// ignore: must_be_immutable
class MySavingUpNav extends StatelessWidget {
  MySavingUpNav({super.key});
  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) =>
          ProfileCubit(profileRepository: ProfileRepository())..fetchProfile(),
      child: navBloc(),
    );
  }

  Widget navBloc() {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is ProfileError) {
          return Center(
            child: Text('Cos poszlo nie tak'),
          );
        }
        if (state is ProfileLoaded) {
          final profiles = state.profiles;
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      profiles![0].pictureImage.isEmpty
                          ? SizedBox(
                              width: 50,
                              child: Image.asset(images.defaultProfilePicture))
                          : Container(
                              width: 50,
                              child: CircleAvatar(
                                radius: 30,
                                // Adjust the radius as per your requirements
                                backgroundImage:
                                    NetworkImage("${profiles[0].pictureImage}"),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dzień dobry 🔆',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: MySavingColors.defaultDarkText),
                            ),
                            Text(
                              profiles![0].name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MySavingColors.defaultDarkText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications,
                        color: MySavingColors.defaultDarkText))
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
