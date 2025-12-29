import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Gradient definitions for What To Do app
abstract class AppGradients {
  /// Main background gradient (Dark mode)
  static const LinearGradient backgroundDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.secondary900, AppColors.secondary950, Color(0xFF050410)],
    stops: [0.0, 0.5, 1.0],
  );

  /// Main background gradient (Light mode)
  static const LinearGradient backgroundLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.secondary50, AppColors.neutral50, Colors.white],
    stops: [0.0, 0.5, 1.0],
  );

  /// Primary gradient (buttons, CTAs)
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary500, AppColors.primary700],
  );

  /// Activity card gradient
  static const LinearGradient activityCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary500, AppColors.secondary600],
  );

  /// Accent gradient (special highlights)
  static const LinearGradient accent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.accent500, AppColors.accent700],
  );

  /// Card gradient for dark mode
  static LinearGradient cardDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.secondary800.withValues(alpha: 0.8),
      AppColors.secondary900.withValues(alpha: 0.6),
    ],
  );

  /// Shimmer gradient
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

