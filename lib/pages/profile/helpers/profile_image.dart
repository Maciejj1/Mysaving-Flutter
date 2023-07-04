import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/pages/profile/config/cubit/profile_cubit.dart';

import '../../../common/utils/mysaving_images.dart';
import '../../../data/repositories/profile_repository.dart';

// ignore: must_be_immutable
class ProfileImage extends StatelessWidget {
  ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(profileRepository: ProfileRepository())..fetchProfile(),
      child: profileImageBloc(),
    );
  }

  MySavingImages images = MySavingImages();
  Widget profileImageBloc() {
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
            // Wyświetl dane profilowe
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profiles![0].pictureImage.isEmpty
                      ? Container(
                          width: 150,
                          child: Image.asset(images.defaultProfilePicture),
                        )
                      : Container(
                          width: 150,
                          child: CircleAvatar(
                            radius:
                                75, // Adjust the radius as per your requirements
                            backgroundImage:
                                NetworkImage("${profiles[0].pictureImage}"),
                          ),
                        ),
                  Column(
                    children: [
                      Text(
                        "Dzień dobry,🔆",
                        style: TextStyle(
                            fontSize: 18,
                            color: MySavingColors.defaultDarkText),
                      ),
                      Text(
                        "${profiles[0].name}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MySavingColors.defaultDarkText),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}
