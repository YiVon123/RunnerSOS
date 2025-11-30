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
      surface: AppColors.light,
      onSurface: AppColors.button,
    ),

    scaffoldBackgroundColor: AppColors.background,

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
