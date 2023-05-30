import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/config/repository/apple_repository.dart';
import 'package:mysavingapp/config/repository/auth_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../common/helpers/mysaving_snackbar.dart';
import '../../login/helpers/html_shim.dart' if (dart.library.html) 'dart:html'
    show window;
import 'cubit/apple_cubit.dart';

class AppleLoginScreen extends StatelessWidget {
  const AppleLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppleCubit>(
      create: (_) => AppleCubit(AppleRepository(FirebaseAuth.instance)),
      child: AppleLoginForm(),
    );
  }
}

class AppleLoginForm extends StatelessWidget {
  const AppleLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppleCubit, AppleState>(
      listener: (context, state) {
        if (state.status == AppleStatus.success) {
          showTopSnackBar(
            Overlay.of(context),
            MysavingSnackBar.success(
              message: "Pomyślnie zalogowano. Witaj :D", //brak
            ),
          );
        }
      },
      child: AppleLogin(),
    );
  }
}

class AppleLogin extends StatelessWidget {
  const AppleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppleCubit, AppleState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == AppleStatus.submitting
            ? const CircularProgressIndicator.adaptive()
            : ElevatedButton(
                onPressed: () {
                  context.read<AppleCubit>().signUpFormSubmitted();
                },
                child: Text('Login via apple'));
      },
    );
  }
}
