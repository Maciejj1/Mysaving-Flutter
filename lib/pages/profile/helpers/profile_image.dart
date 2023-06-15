import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/pages/profile/config/cubit/profile_cubit.dart';

import '../../../common/utils/mysaving_images.dart';
import '../../../config/repository/profile_repository.dart';

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
                  // Text(
                  //   "Data urodzenia: ${profiles![0].dateOfBirth}",
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  // Text(
                  //   "Email: ${profiles[0].email}",
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  // Text(
                  //   "Hasło: ${profiles[0].password}",
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  profiles![0].pictureImage.isEmpty
                      ? Container(
                          width: 150,
                          child: Image.asset(images.defaultProfilePicture),
                        )
                      : Text(
                          "Zdjęcie: ${profiles[0].pictureImage}",
                          style: TextStyle(fontSize: 18),
                        ),
                  Column(
                    children: [
                      Text(
                        "Good Morning,",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${profiles[0].name}",
                        style: TextStyle(fontSize: 18),
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
