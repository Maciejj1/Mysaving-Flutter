import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/repository/profile_repository.dart';
import 'config/cubit/profile_cubit.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileCubit _profileCubit;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pictureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit(profileRepository: ProfileRepository());
    _profileCubit.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileCubit,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoaded) {
                            final profiles = state.profiles;
                            // Wyświetl dane profilowe
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Data urodzenia: ${profiles![0].dateOfBirth}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Email: ${profiles[0].email}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Hasło: ${profiles[0].password}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Imię: ${profiles[0].name}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Zdjęcie: ${profiles[0].pictureImage}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            );
                          } else {
                            // Wyświetl informację o ładowaniu lub błędzie
                            return Text(
                              "Wczytywanie danych...",
                              style: TextStyle(fontSize: 18),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Otwórz formularz do zmiany hasła
                    _openPasswordForm(context);
                  },
                  child: Text("Zmień hasło"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Otwórz formularz do zmiany emaila
                    _openEmailForm(context);
                  },
                  child: Text("Zmień email"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Otwórz formularz do zmiany nazwy
                    _openNameForm(context);
                  },
                  child: Text("Zmień nazwę"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Otwórz formularz do ustawienia zdjęcia profilowego
                    _openPictureForm(context);
                  },
                  child: Text("Ustaw zdjęcie"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                _profileCubit.updatePassword(_passwordController.text);
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
                _profileCubit.updateEmail(_emailController.text);
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
                _profileCubit.updateName(_nameController.text);
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
                _profileCubit.updateProfilePicture(_pictureController.text);
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
}
