import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/config/routes/mysaving_routes.dart';
import 'package:mysavingapp/common/theme/theme_constants.dart';
import 'package:mysavingapp/data/repositories/auth_repository.dart';
import 'package:mysavingapp/data/firebase/firebase_options.dart';
import 'package:mysavingapp/data/repositories/profile_repository.dart';
import 'package:provider/provider.dart';

import 'bloc/app_bloc.dart';
import 'common/theme/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authRepository = AuthRepository();
  runApp(
    MyApp(
      authRepository: authRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;

  const MyApp({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    DarkModeSwitch.initDarkMode();
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => DarkModeBloc(),
          ),
          BlocProvider(
            create: (_) => AppBloc(authRepository: _authRepository),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: themeNotifier.getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Go router',

      home: FlowBuilder(
        onGeneratePages: onGeneratedMysavingViewPages,
        state: context.select((AppBloc bloc) => bloc.state.status),
      ),
    );
  }
}
