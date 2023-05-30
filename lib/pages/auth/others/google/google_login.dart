import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mysavingapp/config/repository/auth_repository.dart';
import 'package:mysavingapp/config/repository/google_repository.dart';
import 'package:mysavingapp/pages/auth/others/google/cubit/google_cubit.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../common/helpers/mysaving_snackbar.dart';

class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoogleCubit>(
      create: (_) => GoogleCubit(GoogleRepository()),
      child: GoogleLoginForm(),
    );
  }
}

class GoogleLoginForm extends StatelessWidget {
  const GoogleLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleCubit, GoogleState>(
      listener: (context, state) {
        if (state.status == GoogleStatus.success) {
          showTopSnackBar(
            Overlay.of(context),
            MysavingSnackBar.success(
              message: "Pomyślnie zalogowano. Witaj :D", //brak
            ),
          );
        }
      },
      child: Column(
        children: [GoogleLogin()],
      ),
    );
  }
}

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleCubit, GoogleState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == GoogleStatus.submitting
            ? const CircularProgressIndicator.adaptive()
            : ElevatedButton(
                onPressed: () {
                  context.read<GoogleCubit>().signUpFormSubmitted();
                },
                child: Text('Login with google'),
              );
      },
    );
  }
}
