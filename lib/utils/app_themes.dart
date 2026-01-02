import 'package:flutter/material.dart';
import 'package:runner_sos/utils/app_colors.dart';
import 'package:runner_sos/utils/app_textstyles.dart';

class AppThemes {
  static final light = ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      headlineLarge: AppTextstyles.h1,
      headlineMedium: AppTextstyles.h2,
      headlineSmall: AppTextstyles.h3,
      bodyLarge: AppTextstyles.h4,
      //.....
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.button,
      onPrimary: AppColors.background,
      secondary: AppColors.sos,
      onSecondary: AppColors.background,
      error: Colors.red,
      onError: AppColors.background,
      surface: AppColors.background,
      onSurface: AppColors.button,
    ),

    scaffoldBackgroundColor: AppColors.background,

    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.button, // Icon and text color
      elevation: 0,
      centerTitle: false,
    ),

    // Bottom Navigation Bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.button,
      unselectedItemColor: AppColors.medium,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.button,
        foregroundColor: AppColors.background,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
