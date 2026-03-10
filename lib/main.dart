import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cache/cache_helper.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/data_source/auth_firebase_data_source.dart';
import 'features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'features/auth/domian/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await CacheHelper.init();

  final AuthFirebaseDataSource authDataSource = AuthFirebaseDataSource();
  final AuthRepository repository = AuthRepositoryImpl(authDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AuthRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(repository),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Route Movies App',
            theme: AppTheme.darkTheme,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}