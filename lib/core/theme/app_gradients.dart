import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppGradients {
  static const LinearGradient backgroundDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.secondary900, AppColors.secondary950, Color(0xFF050410)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient backgroundLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.secondary50, AppColors.neutral50, Colors.white],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary500, AppColors.primary700],
  );

  static const LinearGradient activityCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary500, AppColors.secondary600],
  );

  static const LinearGradient accent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.accent500, AppColors.accent700],
  );

  static LinearGradient cardDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.secondary800.withValues(alpha: 0.8),
      AppColors.secondary900.withValues(alpha: 0.6),
    ],
  );

  static LinearGradient shimmer(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [
              AppColors.secondary800,
              AppColors.secondary800.withValues(alpha: 0.5),
              AppColors.secondary800,
            ]
          : [AppColors.neutral200, AppColors.neutral100, AppColors.neutral200],
    );
  }
}

