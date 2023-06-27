import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/data/repositories/google_repository.dart';
import 'package:mysavingapp/pages/auth/others/google/cubit/google_cubit.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../common/helpers/mysaving_snackbar.dart';
import '../../../../common/utils/mysaving_images.dart';

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
              message: "Pomyślnie zalogowano. Witaj :D",
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

// ignore: must_be_immutable
class GoogleLogin extends StatelessWidget {
  GoogleLogin({super.key});
  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleCubit, GoogleState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == GoogleStatus.submitting
            ? const CircularProgressIndicator.adaptive()
            : RawMaterialButton(
                onPressed: () {
                  context.read<GoogleCubit>().signUpFormSubmitted();
                },
                elevation: 1.0,
                fillColor: Colors.white,
                child:
                    SizedBox(width: 20, child: Image.asset(images.googleImage)),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              );
      },
    );
  }
}
