import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/common/helpers/mysaving_snackbar.dart';
import 'package:mysavingapp/config/repository/auth_repository.dart';
import 'package:mysavingapp/pages/auth/register/cubit/register_cubit.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

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
          Navigator.pop(context);
          showTopSnackBar(
            Overlay.of(context),
            MysavingSnackBar.success(
              message: "Pomyślnie zarejestrowano. Witaj ${state.email}", //brak
            ),
          );
        }
        if (state.status == RegisterStatus.error) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Oops... Something went wrong", //brak
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
            state.password.length < 5 &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wpisałeś za krótkie hasło", //brak
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
            !regex.hasMatch(state.email) &&
            state.email.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Wpisałeś zły email", //brak
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
            state.email.isEmpty &&
            state.password.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Nie wpisałeś email", //brak
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
            state.password.isEmpty &&
            state.email.isNotEmpty) {
          showTopSnackBar(
            Overlay.of(context),
            const MysavingSnackBar.error(
              message: "Nie wpisałeś password", //brak
            ),
          );
        }
        if (state.status == RegisterStatus.success &&
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
          RegisterEmailTextField(),
          SizedBox(
            height: 10,
          ),
          RegisterPasswordTextField(),
          SizedBox(
            height: 10,
          ),
          RegisterButton()
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
          Row(
            children: [Text('Email')],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (email) {
              context.read<RegisterCubit>().emailChanged(email);
            },
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
          Row(
            children: [Text('Password')],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (password) {
              context.read<RegisterCubit>().passwordChanged(password);
            },
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
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<RegisterCubit>().signUpFormSubmitted();
                      },
                      child: Text('Register')),
                );
        });
  }
}
