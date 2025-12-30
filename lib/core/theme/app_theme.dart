import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'package:what_to_do_app/core/constants/app_constants.dart';

class AppTheme {
  static const Color primaryColor = AppColors.primary500;
  static const Color secondaryColor = AppColors.secondary600;
  static const Color tertiaryColor = AppColors.accent300;
  static const Color quaternaryColor = AppColors.secondary800;
  static const Color white = AppColors.white;
  static const Color black = AppColors.black;
  static const Color successColor = AppColors.success;
  static const Color warningColor = AppColors.warning;
  static const Color errorColor = AppColors.error;
  static const Color darkSurface = AppColors.secondary900;
  static const Color darkCard = AppColors.secondary800;
  static const Color darkBackground = AppColors.secondary950;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      brightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.secondary50,
      primaryColor: AppColors.primary500,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary500,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primary100,
        onPrimaryContainer: AppColors.primary700,

        secondary: AppColors.secondary600,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondary100,
        onSecondaryContainer: AppColors.secondary700,

        tertiary: AppColors.accent300,
        onTertiary: AppColors.secondary800,

        surface: AppColors.white,
        onSurface: AppColors.neutral900,

        error: AppColors.error,
        onError: AppColors.white,

        outline: AppColors.secondary200,
        outlineVariant: AppColors.neutral200,
      ),

      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.neutral900,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: AppColors.neutral900),
        titleTextStyle: const TextStyle(
          color: AppColors.neutral900,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          fontFamily: 'Roboto',
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.white,
        shadowColor: AppColors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.secondary200, width: 1),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.secondary200,
        thickness: 1,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: const TextStyle(color: AppColors.neutral400),
        labelStyle: const TextStyle(color: AppColors.neutral600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.secondary200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.secondary200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary500,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.primary200,
          disabledForegroundColor: AppColors.white.withValues(alpha: 0.7),
          minimumSize: const Size(
            double.infinity,
            AppConstants.buttonMinHeight,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
          ),
          elevation: AppConstants.buttonElevation,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            fontFamily: 'Roboto',
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary600,
          backgroundColor: AppColors.primary100,
          side: const BorderSide(color: AppColors.primary500),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary600),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primary100,
        labelStyle: const TextStyle(color: AppColors.primary700),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary500,
        linearTrackColor: AppColors.primary100,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.neutral900,
        contentTextStyle: const TextStyle(color: AppColors.neutral50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      textTheme: _buildTextTheme(isDark: false),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.secondary950,
      primaryColor: AppColors.primary500,

      colorScheme: ColorScheme.dark(
        primary: AppColors.primary500,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primary700,
        onPrimaryContainer: AppColors.primary100,

        secondary: AppColors.secondary600,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondary700,
        onSecondaryContainer: AppColors.secondary100,

        tertiary: AppColors.secondary800,
        onTertiary: AppColors.white,

        surface: AppColors.secondary900,
        onSurface: AppColors.white,

        error: AppColors.errorDark,
        onError: AppColors.white,

        outline: AppColors.primary500.withValues(alpha: 0.3),
        outlineVariant: AppColors.neutral50.withValues(alpha: 0.1),
      ),

      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.secondary950,
        foregroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: const TextStyle(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          fontFamily: 'Roboto',
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.secondary800.withValues(alpha: 0.6),
        shadowColor: AppColors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.primary500.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: AppColors.primary500.withValues(alpha: 0.3),
        thickness: 1,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondary800,
        hintStyle: TextStyle(color: AppColors.white.withValues(alpha: 0.5)),
        labelStyle: const TextStyle(color: AppColors.secondary300),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primary500.withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primary500.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary500,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.primary500.withValues(alpha: 0.3),
          disabledForegroundColor: AppColors.white.withValues(alpha: 0.5),
          minimumSize: const Size(
            double.infinity,
            AppConstants.buttonMinHeight,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
          ),
          elevation: AppConstants.buttonElevation,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            fontFamily: 'Roboto',
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary400,
          side: BorderSide(color: AppColors.primary500.withValues(alpha: 0.5)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary400),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primary500.withValues(alpha: 0.15),
        labelStyle: const TextStyle(color: AppColors.primary300),
        side: BorderSide(color: AppColors.primary500.withValues(alpha: 0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary500,
        linearTrackColor: AppColors.secondary800,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.secondary800,
        contentTextStyle: const TextStyle(color: AppColors.neutral50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.secondary900,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.secondary900,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      textTheme: _buildTextTheme(isDark: true),
    );
  }

  static ThemeData get theme => lightTheme;

  static TextTheme _buildTextTheme({required bool isDark}) {
    final Color primaryText = isDark ? AppColors.white : AppColors.neutral900;
    final Color secondaryText = isDark
        ? AppColors.white.withValues(alpha: 0.7)
        : AppColors.neutral900.withValues(alpha: 0.7);

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -1,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        letterSpacing: 0,
        color: secondaryText,
        height: 1.5,
        fontFamily: 'Roboto',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        letterSpacing: 0,
        color: secondaryText,
        fontFamily: 'Roboto',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        letterSpacing: 0,
        color: secondaryText,
        fontFamily: 'Roboto',
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primaryText,
        fontFamily: 'Roboto',
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: secondaryText,
        fontFamily: 'Roboto',
      ),
    );
  }
}

extension AppThemeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get textPrimary =>
      isDarkMode ? AppColors.white : AppColors.neutral900;

  Color get textSecondary => isDarkMode
      ? AppColors.white.withValues(alpha: 0.7)
      : AppColors.neutral900.withValues(alpha: 0.7);

  Color get cardBackground =>
      isDarkMode ? AppColors.secondary800 : AppColors.white;

  Color get screenBackground =>
      isDarkMode ? AppColors.secondary950 : AppColors.secondary50;

  Color get surfaceColor =>
      isDarkMode ? AppColors.secondary900 : AppColors.white;

  Color get borderColor => isDarkMode
      ? AppColors.primary500.withValues(alpha: 0.3)
      : AppColors.secondary200;

  Color get inputFillColor =>
      isDarkMode ? AppColors.secondary800 : AppColors.white;

  Color get shimmerBase =>
      isDarkMode ? AppColors.secondary800 : AppColors.neutral200;

  Color get shimmerHighlight =>
      isDarkMode ? AppColors.secondary900 : AppColors.neutral100;

  BoxDecoration get glassDecoration {
    return BoxDecoration(
      color: isDarkMode
          ? AppColors.secondary800.withValues(alpha: 0.6)
          : AppColors.white.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: borderColor),
    );
  }

  List<BoxShadow>? get primaryGlow {
    if (!isDarkMode) return null;
    return [
      BoxShadow(
        color: AppColors.primary500.withValues(alpha: 0.4),
        blurRadius: 20,
        spreadRadius: 0,
      ),
    ];
  }
}
