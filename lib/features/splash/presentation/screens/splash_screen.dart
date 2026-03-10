/*import 'package:flutter/material.dart';

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
*/
//........................
// 1. أضفنا هذه المكتبات الجديدة التي سنحتاجها
import 'dart:async';
import 'package:flutter/material.dart';
// تأكدي من أن هذا المسار صحيح لملف OnboardingPage في مشروعك
import 'package:movies_app/features/onboarding/presentation/widgets/onboarding_page.dart';

// الكلاس الأول: لم يتغير كثيرًا، مجرد إعدادات
class SplashScreen extends StatefulWidget {
  static const String routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// الكلاس الثاني: هذا هو "العقل" الذي يحتوي على المنطق والتصميم
class _SplashScreenState extends State<SplashScreen> {

  // 2. أضفنا دالة initState التي تعمل مرة واحدة عند بدء الشاشة
  @override
  void initState() {
    super.initState();
    // عند بدء الشاشة، نقوم بتشغيل مؤقت لمدة 3 ثوانٍ
    Timer(const Duration(seconds: 3), () {
      // بعد انتهاء الـ 3 ثوانٍ، نقوم بالانتقال إلى شاشة Onboarding
      // نستخدم pushReplacement لمنع المستخدم من العودة إلى شاشة البداية بالضغط على زر "رجوع"
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    });
  }

  // 3. دالة build الآن تحتوي على نفس تصميمك الرائع الذي لم يتغير
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