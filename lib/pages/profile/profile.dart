import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysavingapp/common/helpers/profile_nav.dart';
import 'package:mysavingapp/data/repositories/profile_repository.dart';
import 'package:mysavingapp/pages/profile/config/cubit/profile_cubit.dart';
import 'package:mysavingapp/pages/profile/helpers/profile_buttons.dart';
import 'package:mysavingapp/pages/profile/helpers/profile_image.dart';
import 'package:provider/provider.dart';

import '../../bloc/app_bloc.dart';
import '../../common/helpers/mysaving_switch.dart';
import '../../common/theme/bloc/theme_bloc.dart';
import '../../common/utils/mysaving_colors.dart';
import '../../common/utils/mysaving_images.dart';
import '../../common/theme/theme_constants.dart';
import 'helpers/widgets/profile_button.dart';

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
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit()..fetchProfile(),
            ),
            BlocProvider<DarkModeBloc>(
              create: (context) => DarkModeBloc(),
            ),
          ],
          child: profileForm(),
        ),
      ),
    );
  }

  Widget profileImageBloc() {
    MySavingImages images = MySavingImages();
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

  Widget profileForm() {
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
          return Column(
            children: [
              ProfileNav(),
              Gap(20),
              profileImageBloc(),
              Gap(20),
              switchToDark(),
              // MysavingSwitch(
              //   isSwitchedValue: DarkModeSwitch.isDarkMode,
              //   onSwitchChanged: (bool isDarkMode) {
              //     changeTheme();
              //   },
              // ),
              Gap(20),
              buttonsForm(),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget switchToDark() {
    return BlocBuilder<DarkModeBloc, DarkModeState>(
      builder: (context, state) {
        return Switch(
          value: DarkModeSwitch.isDarkMode,
          onChanged: (value) {
            setState(() {});
            BlocProvider.of<DarkModeBloc>(context).add(ToggleDarkModeEvent());
          },
        );
      },
    );
  }

  Widget buttonsForm() {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
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
          final profileCubit = context.read<ProfileCubit>();

          Future<void> _pickImageFromGallery() async {
            final pickedImage =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              final imagePath = pickedImage.path;
              profileCubit.updateProfilePicture(imagePath);
              setState(() {}); // Odświeżenie widoku
            }
          }

          void _openPasswordForm(BuildContext context) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Zmień hasło"),
                  content: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: "Nowe hasło"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        profileCubit.updatePassword(_passwordController.text);
                        setState(() {}); // Odświeżenie widoku
                        Navigator.of(context).pop();
                      },
                      child: Text("Zapisz"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Anuluj"),
                    ),
                  ],
                );
              },
            );
          }

          void _openEmailForm(BuildContext context) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Zmień email"),
                  content: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "Nowy email"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        profileCubit.updateEmail(_emailController.text);
                        Navigator.of(context).pop();
                      },
                      child: Text("Zapisz"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Anuluj"),
                    ),
                  ],
                );
              },
            );
          }

          void _openNameForm(BuildContext context) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Zmień nazwę"),
                  content: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nowa nazwa"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        profileCubit.updateName(_nameController.text);
                        Navigator.of(context).pop();
                      },
                      child: Text("Zapisz"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Anuluj"),
                    ),
                  ],
                );
              },
            );
          }

          return Column(
            children: [
              ProfileButton(
                  buttonText: 'Zmień nazwę',
                  buttonMethod: () {
                    _openNameForm(context);
                  }),
              Gap(15),
              ProfileButton(
                  buttonText: 'Zmień hasło',
                  buttonMethod: () {
                    _openPasswordForm(context);
                  }),
              Gap(15),
              ProfileButton(
                  buttonText: 'Zmień Email',
                  buttonMethod: () {
                    _openEmailForm(context);
                  }),
              Gap(15),
              ProfileButton(
                  buttonText: 'Zmień zdjęcie',
                  buttonMethod: () {
                    _pickImageFromGallery();
                  }),
              Gap(15),
              ProfileButton(
                  buttonText: 'Wyloguj',
                  buttonMethod: () {
                    context.read<AppBloc>().add(AppLogoutRequested());
                  })
            ],
          );
        }
        return Container();
      },
    );
  }
}
