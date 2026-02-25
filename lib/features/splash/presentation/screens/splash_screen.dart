import 'package:flutter/material.dart';
import 'package:movies_app/features/onboarding/presentation/widgets/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // بعد 3 ثواني يروح للأون بوردينج
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: Column(
        children: [
          const Spacer(flex: 5),

          // ===== Play Icon =====
          Center(
            child: Transform.translate(
              offset: const Offset(-8, 0),
              child: Image.asset(
                'assets/icons/play_icon.png',
                width: 190,
                height: 190,
              ),
            ),
          ),

          const Spacer(flex: 5),

          // ===== Route Logo =====
          Image.asset(
            'assets/images/route_logo.png',
            width: 150,
          ),

          const SizedBox(height: 3),

          // ===== Supervised Text =====
          const Text(
            'Supervised by Mohamed Nabil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}