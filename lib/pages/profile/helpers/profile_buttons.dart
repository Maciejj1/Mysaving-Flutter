import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/bloc/app_bloc.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        ElevatedButton(
            onPressed: () {
              context.read<AppBloc>().add(AppLogoutRequested());
            },
            child: Text('Wyloguj')),
      ],
    );
  }

  void _openPasswordForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Zmień hasło"),
          content: TextField(
            decoration: InputDecoration(hintText: "Nowe hasło"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // _profileCubit.updatePassword(_passwordController.text);
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
            // controller: _emailController,
            decoration: InputDecoration(hintText: "Nowy email"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // _profileCubit.updateEmail(_emailController.text);
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
            // controller: _nameController,
            decoration: InputDecoration(hintText: "Nowa nazwa"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // _profileCubit.updateName(_nameController.text);
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
            // controller: _pictureController,
            decoration: InputDecoration(hintText: "Nowe zdjęcie"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // _profileCubit.updateProfilePicture(_pictureController.text);
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
