import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/presentation/screens/register_screen.dart';

import 'core/constants/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
      runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize: Size(390, 844), // your design size (width x height)
        minTextAdapt: true, // adjusts text for small screens
        builder: (context, child) => MaterialApp(
          theme: AppTheme.appTheme,
          title: 'Movies App',
          debugShowCheckedModeBanner: false,
          home: RegisterScreen(),
      ),
    );
  }
}