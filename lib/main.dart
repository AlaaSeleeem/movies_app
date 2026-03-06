import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Core Imports
import 'core/cache/cache_helper.dart';
import 'core/theme/app_theme.dart';

// Feature Auth Imports
import 'features/auth/data/data_source/auth_firebase_data_source.dart';
import 'features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'features/auth/domian/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/onboarding/presentation/widgets/onboarding_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();

  final AuthFirebaseDataSource authDataSource = AuthFirebaseDataSource();
  final AuthRepository repository = AuthRepositoryImpl(authDataSource);

  User? currentUser = FirebaseAuth.instance.currentUser;
  Widget startWidget;
  if (currentUser != null) {
    startWidget = const LoginScreen();
  } else {
    startWidget = const RegisterScreen();
  }

  runApp(MyApp(startWidget: startWidget, repository: repository));
}

class MyApp extends StatelessWidget {
  final AuthRepository repository;
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget, required this.repository});

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
            home: startWidget,
          );
        },
      ),
    );
  }
}