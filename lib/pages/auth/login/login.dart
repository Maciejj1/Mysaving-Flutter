import 'dart:io';
// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)
import 'package:mysavingapp/config/repository/apple_repository.dart';
import 'package:mysavingapp/config/repository/google_repository.dart';
import 'package:mysavingapp/pages/auth/others/apple/apple_login.dart';
import 'package:mysavingapp/pages/auth/others/google/google_login.dart';

import './helpers/html_shim.dart' if (dart.library.html) 'dart:html'
    show window;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../common/helpers/mysaving_snackbar.dart';
import '../../../config/repository/auth_repository.dart';
import '../others/apple/cubit/apple_cubit.dart';
import '../others/google/cubit/google_cubit.dart';
import '../register/register.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static Page<void> page() => const MaterialPage<void>(child: LoginScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(40),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginCubit>(
              create: (_) => LoginCubit(AuthRepository()),
            ),
            BlocProvider<AppleCubit>(
              create: (context) =>
                  AppleCubit(AppleRepository(FirebaseAuth.instance)),
            ),
            BlocProvider<GoogleCubit>(
              create: (context) => GoogleCubit(GoogleRepository()),
            ),
          ],
          child: LoginForm(),
        ),
      )),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
            r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
            r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
        final regex = RegExp(pattern);
        if (state.status == LoginStatus.success &&
            state.password.length > 5 &&
            regex.hasMatch(state.email) &&
            state.email.isNotEmpty &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            MysavingSnackBar.success(
              message: "Pomyślnie zalogowano. Witaj ${state.email}", //brak
            ),
          );
        }
        if (state.status == LoginStatus.error) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Oops... Something went wrong", //brak
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            state.password.length < 5 &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wpisałeś za krótkie hasło", //brak
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            !regex.hasMatch(state.email) &&
            state.email.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wpisałeś zły email", //brak
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            state.email.isEmpty &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Nie wpisałeś email", //brak
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            state.password.isEmpty &&
            state.email.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Nie wpisałeś password", //brak
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            state.email.isEmpty &&
            state.password.isEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wypełnij formularz", //brak
            ),
          );
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          LoginEmailTextField(),
          SizedBox(
            height: 10,
          ),
          LoginPasswordTextField(),
          SizedBox(
            height: 10,
          ),
          LoginButton(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dont have account?'),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push<void>(RegisterScreen.route());
                  },
                  child: Text('Register here'))
            ],
          ),
          AppleLoginScreen(),
          GoogleLoginScreen(),
        ],
      ),
    );
  }
}

class LoginEmailTextField extends StatelessWidget {
  const LoginEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [Text('Email')],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (email) {
              context.read<LoginCubit>().emailChanged(email);
            },
          )
        ],
      );
    });
  }
}

class LoginPasswordTextField extends StatelessWidget {
  const LoginPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [Text('Password')],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (password) {
              context.read<LoginCubit>().passwordChanged(password);
            },
          )
        ],
      );
    });
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status == LoginStatus.submitting
              ? const CircularProgressIndicator.adaptive()
              : Container(
                  height: 44,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().singInFormSubmitted();
                      },
                      child: Text('Login')),
                );
        });
  }
}
