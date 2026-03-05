
// دي بعد  ما ضفنا اللوجيك
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies_app/features/splash/presentation/screens/splash_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'firebase_options.dart'; // flutterfire configure عملناه ب
import 'features/auth/data/repos/auth_repo.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/reset_password_screen.dart';

// دي الموجودة من قبل
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/onboarding/presentation/widgets/onboarding_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //........
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        //....................
        return BlocProvider(
          create: (context) => AuthBloc(authRepo: AuthRepo()),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme: AppTheme.darkTheme,
            // .............
            home: const SplashScreen(),


            routes: {
              '/login': (context) => const LoginScreen(),
              '/resetPassword': (context) => const ResetPasswordScreen(),
            },
          ),
        );
      },
    );
  }
}