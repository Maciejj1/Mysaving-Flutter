import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/common/routes/mysaving_routes.dart';
import 'package:mysavingapp/config/repository/auth_repository.dart';
import 'package:mysavingapp/firebase_options.dart';
import 'package:provider/provider.dart';

import 'config/bloc/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authRepository = AuthRepository();
  runApp(MyApp(
    authRepository: authRepository,
  ));
}

// class MyApp extends StatelessWidget {
//   final AuthRepository _authRepository;
//   MyApp({Key? key, required AuthRepository authRepository})
//       : _authRepository = authRepository,
//         super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//         value: _authRepository,
//         child: BlocProvider(
//           create: (_) => AppBloc(authRepository: _authRepository),
//           child: MaterialApp.router(
//             routeInformationParser: AppRouter.router.routeInformationParser,
//             routerDelegate: AppRouter.router.routerDelegate,
//             routeInformationProvider: AppRouter.router.routeInformationProvider,
//             title: 'Go router',
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//             ),
//           ),
//         ));
//   }
// }
class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(authRepository: _authRepository),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go router',
      home: FlowBuilder(
        onGeneratePages: onGeneratedMysavingViewPages,
        state: context.select((AppBloc bloc) => bloc.state.status),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
