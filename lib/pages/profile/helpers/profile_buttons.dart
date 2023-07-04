import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/data/repositories/profile_repository.dart';
import 'package:mysavingapp/pages/profile/config/cubit/profile_cubit.dart';
import 'package:mysavingapp/pages/profile/helpers/widgets/profile_button.dart';

import '../../../bloc/app_bloc.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(profileRepository: ProfileRepository()),
      child: ProfileButtonsForm(),
    );
  }
}

class ProfileButtonsForm extends StatefulWidget {
  const ProfileButtonsForm({Key? key}) : super(key: key);

  @override
  _ProfileButtonsFormState createState() => _ProfileButtonsFormState();
}

class _ProfileButtonsFormState extends State<ProfileButtonsForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pictureController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _pictureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        final profileCubit = context.read<ProfileCubit>();

        Future<void> _pickImageFromGallery() async {
          final pickedImage =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            final imagePath = pickedImage.path;
            profileCubit.updateProfilePicture(imagePath);
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

        void _openPictureForm(BuildContext context) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Ustaw zdjęcie"),
                content: TextField(
                  controller: _pictureController,
                  decoration: InputDecoration(hintText: "Nowe zdjęcie"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      profileCubit
                          .updateProfilePicture(_pictureController.text);
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
      },
    );
  }
}
