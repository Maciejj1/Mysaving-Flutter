import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/common/utils/mysaving_images.dart';
import 'package:mysavingapp/data/repositories/apple_repository.dart';
import 'package:mysavingapp/data/repositories/google_repository.dart';
import 'package:mysavingapp/pages/auth/others/apple/apple_login.dart';
import 'package:mysavingapp/pages/auth/others/google/google_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../common/helpers/mysaving_snackbar.dart';
import '../../../data/repositories/auth_repository.dart';
import '../others/apple/cubit/apple_cubit.dart';
import '../others/google/cubit/google_cubit.dart';
import '../register/register.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static Page<void> page() => const MaterialPage<void>(child: LoginScreen());
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

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

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  MySavingImages images = MySavingImages();
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
              message: "Pomyślnie zalogowano. Witaj ${state.email}",
            ),
          );
        }
        if (state.status == LoginStatus.error) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Oops... Something went wrong",
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            state.password.length < 5 &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wpisałeś za krótkie hasło",
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            !regex.hasMatch(state.email) &&
            state.email.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wpisałeś zły email",
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            state.email.isEmpty &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Nie wpisałeś email",
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            state.password.isEmpty &&
            state.email.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Nie wpisałeś password",
            ),
          );
        }
        if (state.status == LoginStatus.success &&
            state.email.isEmpty &&
            state.password.isEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wypełnij formularz",
            ),
          );
        }
      },
      child: Column(
        children: [
          Gap(70),
          SvgPicture.asset(
            images.mysavingLogo,
          ),
          Gap(40),
          Text(
            'Witaj z powrotem',
            style: TextStyle(
                color: MySavingColors.defaultDarkText,
                fontFamily: 'Inter',
                fontSize: 22,
                fontWeight: FontWeight.w800),
          ),
          Gap(60),
          LoginEmailTextField(),
          SizedBox(
            height: 20,
          ),
          LoginPasswordTextField(),
          Gap(60),
          LoginButton(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nie posiadasz konta?'),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push<void>(RegisterScreen.route());
                  },
                  child: Text('Zarejestruj się'))
            ],
          ),
          Text(
            'LUB',
            style: TextStyle(
                color: MySavingColors.defaultDarkText,
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleLoginScreen(),
                AppleLoginScreen(),
              ],
            ),
          )
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
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              onChanged: (email) {
                context.read<LoginCubit>().emailChanged(email);
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.mail),
                  hintText: "Email",
                  hintStyle: TextStyle(
                      color: MySavingColors.defaultGreyText, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: MySavingColors.defaultInputStroke,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: MySavingColors.defaultInputStroke,
                      ))),
            ),
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
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              onChanged: (password) {
                context.read<LoginCubit>().passwordChanged(password);
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Hasło",
                  hintStyle: TextStyle(
                      color: MySavingColors.defaultGreyText, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: MySavingColors.defaultInputStroke,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: MySavingColors.defaultInputStroke,
                      ))),
            ),
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
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MySavingColors.defaultBlueButton),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: () {
                        context.read<LoginCubit>().singInFormSubmitted();
                      },
                      child: Text('Login')),
                );
        });
  }
}
