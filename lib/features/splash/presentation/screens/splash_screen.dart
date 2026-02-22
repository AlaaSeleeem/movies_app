import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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