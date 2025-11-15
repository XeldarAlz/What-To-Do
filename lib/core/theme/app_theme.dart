import 'package:flutter/material.dart';
import 'package:what_to_do_app/core/constants/app_constants.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get theme {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4A148C),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppConstants.headerBackgroundColor,
      textTheme: base.textTheme.apply(
        fontFamily: 'Roboto',
        bodyColor: const Color(0xFF1F1F1F),
        displayColor: const Color(0xFF1F1F1F),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: base.colorScheme.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(
            double.infinity,
            AppConstants.buttonMinHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.buttonBorderRadius,
            ),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
