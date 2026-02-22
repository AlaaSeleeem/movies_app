import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/presentation/screens/register_screen.dart';

import 'core/constants/app_colors.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(), // هنا تحطي السكرين متاعك
    );
  }
}