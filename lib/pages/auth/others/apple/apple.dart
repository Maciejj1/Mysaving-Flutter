import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/config/repository/auth_repository.dart';
import 'package:mysavingapp/pages/auth/others/apple/cubit/apple_cubit.dart';

class AppleLogin extends StatelessWidget {
  const AppleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: BlocBuilder<AppleCubit, AppleState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              context.read<AppleCubit>().signUpFormSubmitted();
            },
            child: Text('Login with apple'),
          );
        },
      ),
    );
  }
}

// class AppleLoginButton extends StatelessWidget {
//   const AppleLoginButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AppleCubit>(
//       create: (_) => AppleCubit(AuthRepository()),
//       child: AppleLogin(),
//     );
//   }
// }
