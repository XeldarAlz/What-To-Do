import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle displayLarge(BuildContext context) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -1,
        height: 1.2,
        color: context.textPrimary,
      );

  static TextStyle display(BuildContext context) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -1,
        color: context.textPrimary,
      );

  static TextStyle screenTitle(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: context.textPrimary,
      );

  static TextStyle sectionTitle(BuildContext context) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: context.textPrimary,
      );

  static TextStyle cardTitle(BuildContext context) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: context.textPrimary,
      );

  static TextStyle subtitle(BuildContext context) => TextStyle(
        fontSize: 16,
        color: context.textSecondary,
        height: 1.5,
      );

  static TextStyle bodyLarge(BuildContext context) => TextStyle(
        fontSize: 16,
        color: context.textPrimary,
        height: 1.5,
      );

  static TextStyle bodyMedium(BuildContext context) =>
      TextStyle(fontSize: 14, color: context.textPrimary);

  static TextStyle bodySmall(BuildContext context) =>
      TextStyle(fontSize: 12, color: context.textSecondary);

  static TextStyle buttonText(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: context.textPrimary,
      );

  static TextStyle labelText(BuildContext context) =>
      TextStyle(fontSize: 12, color: context.textSecondary);

  static TextStyle valueText(BuildContext context) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: context.textPrimary,
      );

  static TextStyle caption(BuildContext context) => TextStyle(
        fontSize: 12,
        color: context.textSecondary,
        fontWeight: FontWeight.w500,
      );

  static TextStyle badge(BuildContext context) => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.white,
      );
}

