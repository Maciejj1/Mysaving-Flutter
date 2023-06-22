import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/helpers/mysaving_snackbar.dart';
import 'package:mysavingapp/config/repository/auth_repository.dart';
import 'package:mysavingapp/pages/app_tutorial/welcome_tutorial.dart';
import 'package:mysavingapp/pages/auth/login/login.dart';
import 'package:mysavingapp/pages/auth/register/cubit/register_cubit.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../common/utils/mysaving_images.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static Page<void> page() => const MaterialPage<void>(child: RegisterScreen());
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(40),
        child: BlocProvider<RegisterCubit>(
          create: (_) => RegisterCubit(AuthRepository()),
          child: RegisterForm(),
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});
  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
            r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
            r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
        final regex = RegExp(pattern);
        if (state.status == RegisterStatus.success &&
            state.password.length > 5 &&
            regex.hasMatch(state.email) &&
            state.email.isNotEmpty &&
            state.password.isNotEmpty) {
          Navigator.of(context).push<void>(WelcomeTutorialScreen.route());
          showTopSnackBar(
            Overlay.of(context),
            MysavingSnackBar.success(
              message: "Pomyślnie zarejestrowano. Witaj ${state.email}",
            ),
          );
        }
        if (state.status == RegisterStatus.error) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Oops... Something went wrong",
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
            state.password.length < 5 &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wpisałeś za krótkie hasło",
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
            !regex.hasMatch(state.email) &&
            state.email.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wpisałeś zły email",
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
            state.email.isEmpty &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Nie wpisałeś email",
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
            state.password.isEmpty &&
            state.email.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Nie wpisałeś password",
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
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
            'Zarejestruj się',
            style: TextStyle(
                color: Color(0xFF202020),
                fontFamily: 'Inter',
                fontSize: 22,
                fontWeight: FontWeight.w800),
          ),
          Gap(60),
          RegisterEmailTextField(),
          SizedBox(
            height: 20,
          ),
          RegisterPasswordTextField(),
          Gap(60),
          RegisterButton(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Posiadasz konto?'),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push<void>(LoginScreen.route());
                  },
                  child: Text('Zaloguj się'))
            ],
          ),
        ],
      ),
    );
  }
}

class RegisterEmailTextField extends StatelessWidget {
  const RegisterEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Column(
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              onChanged: (email) {
                context.read<RegisterCubit>().emailChanged(email);
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.mail),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Color(0xFF87898E), fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: Color(0xFFDADADA),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: Color(0xFFDADADA),
                      ))),
            ),
          )
        ],
      );
    });
  }
}

class RegisterPasswordTextField extends StatelessWidget {
  const RegisterPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Column(
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              onChanged: (password) {
                context.read<RegisterCubit>().passwordChanged(password);
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Hasło",
                  hintStyle: TextStyle(color: Color(0xFF87898E), fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: Color(0xFFDADADA),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: Color(0xFFDADADA),
                      ))),
            ),
          )
        ],
      );
    });
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status == RegisterStatus.submitting
              ? const CircularProgressIndicator.adaptive()
              : Container(
                  height: 44,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF444FFF)),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: () {
                        context.read<RegisterCubit>().signUpFormSubmitted();
                      },
                      child: Text('Register')),
                );
        });
  }
}
