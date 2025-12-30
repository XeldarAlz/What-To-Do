import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary50 = Color(0xFFF5F3FF);
  static const Color primary100 = Color(0xFFEDE9FE);
  static const Color primary200 = Color(0xFFDDD6FE);
  static const Color primary300 = Color(0xFFC4B5FD);
  static const Color primary400 = Color(0xFFA78BFA);
  static const Color primary500 = Color(0xFF7C4DFF); // ⭐ Main primary
  static const Color primary600 = Color(0xFF6D3AED);
  static const Color primary700 = Color(0xFF5B21B6);
  static const Color primary800 = Color(0xFF4A148C);
  static const Color primary900 = Color(0xFF3D0F7A);

  static const Color secondary50 = Color(0xFFF5F2F8);
  static const Color secondary100 = Color(0xFFE9E0F0);
  static const Color secondary200 = Color(0xFFD4C0E1);
  static const Color secondary300 = Color(0xFFBFA0D2);
  static const Color secondary400 = Color(0xFF9B6BB8);
  static const Color secondary500 = Color(0xFF7B4A9F);
  static const Color secondary600 = Color(0xFF512DA8); // ⭐ Current secondary
  static const Color secondary700 = Color(0xFF45208A);
  static const Color secondary800 = Color(0xFF2D1B3D); // ⭐ Dark card
  static const Color secondary900 = Color(0xFF1A1025); // ⭐ Dark surface
  static const Color secondary950 = Color(0xFF0D0A12); // ⭐ Dark background

  static const Color accent50 = Color(0xFFFAF5FF);
  static const Color accent100 = Color(0xFFF3E8FF);
  static const Color accent200 = Color(0xFFE9D5FF);
  static const Color accent300 = Color(0xFFD3D3FF); // ⭐ Current tertiary
  static const Color accent400 = Color(0xFFC4B5FD);
  static const Color accent500 = Color(0xFFB794F6);
  static const Color accent600 = Color(0xFF9F7AEA);
  static const Color accent700 = Color(0xFF805AD5);

  static const Color neutral50 = Color(0xFFF8FAFC); // ⭐ Light bg
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFF87171);
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF34D399);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color primaryColor = primary500;
  static const Color secondaryColor = secondary600;
  static const Color tertiaryColor = accent300;
  static const Color quaternaryColor = secondary800;
  static const Color darkSurface = secondary900;
  static const Color darkCard = secondary800;
  static const Color darkBackground = secondary950;

  static const Color activityCardGradientStart = primary500;
  static const Color activityCardGradientEnd = secondary600;
  static const Color headerBackgroundColor = secondary50;
}

