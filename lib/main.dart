import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysavingapp/config/routes/mysaving_routes.dart';
import 'package:mysavingapp/common/theme/theme_constants.dart';
import 'package:mysavingapp/data/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'bloc/app_bloc.dart';
import 'common/theme/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  await dotenv.load();

  String androidApiKey = dotenv.env['ANDROID_API_KEY']!;
  String androidAppId = dotenv.env['ANDROID_APP_ID']!;
  String androidMessagingSenderId = dotenv.env['ANDROID_MESSAGING_SENDER_ID']!;
  String androidProjectId = dotenv.env['ANDROID_PROJECT_ID']!;
  String androidStorageBucket = dotenv.env['ANDROID_STORAGE_BUCKET']!;

  String iosApiKey = dotenv.env['IOS_API_KEY']!;
  String iosAppId = dotenv.env['IOS_APP_ID']!;
  String iosMessagingSenderId = dotenv.env['IOS_MESSAGING_SENDER_ID']!;
  String iosProjectId = dotenv.env['IOS_PROJECT_ID']!;
  String iosStorageBucket = dotenv.env['IOS_STORAGE_BUCKET']!;
  String iosClientId = dotenv.env['IOS_CLIENT_ID']!;
  String iosBundleId = dotenv.env['IOS_BUNDLE_ID']!;

  await Firebase.initializeApp(
    options: isAndroid
        ? FirebaseOptions(
            apiKey: androidApiKey,
            appId: androidAppId,
            messagingSenderId: androidMessagingSenderId,
            projectId: androidProjectId,
            storageBucket: androidStorageBucket,
          )
        : FirebaseOptions(
            apiKey: iosApiKey,
            appId: iosAppId,
            messagingSenderId: iosMessagingSenderId,
            projectId: iosProjectId,
            storageBucket: iosStorageBucket,
            iosClientId: iosClientId,
            iosBundleId: iosBundleId,
          ),
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
