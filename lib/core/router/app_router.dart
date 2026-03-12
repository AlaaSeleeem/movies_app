import 'package:flutter/material.dart';
import 'package:movies_app/features/%20profile/presentation/screens/update_profile_screen.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/movies/presentation/screens/movie_detail_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case OnboardingIntroScreen.routeName:
        return MaterialPageRoute(
          builder: (context) =>
              OnboardingIntroScreen(
                onNext: () {
                  Navigator.pushNamed(
                    context,
                    "/onboarding",
                  );
                },
              ),
        );

      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case ResetPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );

      case UpdateProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const UpdateProfileScreen(),
        );

      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case MovieDetailsScreen.routeName:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
          //builder: (context) => MovieDetailsScreen(id:movieId),
          builder: (context) => const MovieDetailsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            backgroundColor: Color(0xFF121312),
            body: Center(
              child: Text(
                "No route found",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );

    //builder: (context) => const SplashScreen(),

    //);
    }
  }
}