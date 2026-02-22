import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
abstract class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.yellow,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow, brightness: Brightness.light),
    // AppBar Theme
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.yellow,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        )
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.grey,
      filled: true,
      focusedBorder: OutlineInputBorder(
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.red)

      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      hintStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),


  );



}
