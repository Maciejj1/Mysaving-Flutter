import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/config/repository/apple_repository.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../common/helpers/mysaving_snackbar.dart';
import '../../../../common/utils/mysaving_images.dart';
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
              message: "Pomyślnie zalogowano. Witaj :D",
            ),
          );
        }
      },
      child: AppleLogin(),
    );
  }
}

// ignore: must_be_immutable
class AppleLogin extends StatelessWidget {
  AppleLogin({super.key});
  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppleCubit, AppleState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == AppleStatus.submitting
            ? const CircularProgressIndicator.adaptive()
            : RawMaterialButton(
                onPressed: () {
                  context.read<AppleCubit>().signUpFormSubmitted();
                },
                elevation: 1.0,
                fillColor: Colors.white,
                child:
                    SizedBox(width: 16, child: Image.asset(images.appleImage)),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              );
      },
    );
  }
}
