import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // ---------------------------------------------------------------------------
  // Durations
  // ---------------------------------------------------------------------------
  static const Duration loadingAnimationDuration = Duration(seconds: 1);
  static const Duration confettiDuration = Duration(seconds: 1);

  // ---------------------------------------------------------------------------
  // Pagination / Data
  // ---------------------------------------------------------------------------
  static const int initialPlacesPageSize = 5;
  static const int maxPlacesToFetch = 20;

  // ---------------------------------------------------------------------------
  // Activity Card – Layout & Shadow
  // ---------------------------------------------------------------------------
  static const double activityCardHeight = 250.0;
  static const double activityCardBorderRadius = 28.0;
  static const double activityCardShadowBlur = 24.0;
  static const double activityCardShadowOffset = 16.0;
  static const double activityCardShadowOpacity = 0.35;
  static const double activityCardPadding = 28.0;
  static const double activityCardTextSpacing = 12.0;
  static const double activityCardGradientOverlayTopOpacity = 0.3;
  static const double activityCardGradientOverlayBottomOpacity = 0.7;
  static const Color activityCardGradientStart = Color(0xFF7C4DFF);
  static const Color activityCardGradientEnd = Color(0xFF512DA8);

  // ---------------------------------------------------------------------------
  // Activity Card – Emoji Badge
  // ---------------------------------------------------------------------------
  static const double activityCardEmojiSize = 42.0;
  static const double activityCardEmojiScale = 0.75;
  static const double activityCardBadgePaddingHorizontal = 12.0;
  static const double activityCardBadgePaddingVertical = 6.0;
  static const double activityCardBadgeBorderOpacity = 0.2;

  // ---------------------------------------------------------------------------
  // Activity Card – Info Panel
  // ---------------------------------------------------------------------------
  static const double activityCardInfoPaddingHorizontal = 18.0;
  static const double activityCardInfoPaddingVertical = 12.0;
  static const double activityCardInfoWidthFactor = 0.9;
  static const double activityCardInfoBackgroundOpacity = 0.3;
  static const double activityCardInfoBorderOpacity = 0.18;
  static const double activityCardInfoBlurSigma = 16.0;

  // ---------------------------------------------------------------------------
  // Activity Card – Highlight Animation
  // ---------------------------------------------------------------------------
  static const double activityHighlightBorderRadiusOffset = 6.0;
  static const double activityHighlightBorderWidth = 5.0;
  static const double activityHighlightMaxBlur = 13.5;
  static const double activityHighlightMaxSpread = 12.0;
  static const Duration activityHighlightDuration = Duration(
    milliseconds: 20000,
  );
  static const Color activityHighlightColor = Color.fromARGB(255, 255, 255, 0);

  // ---------------------------------------------------------------------------
  // Activity Card – Pop Animation
  // ---------------------------------------------------------------------------
  static const double activityPopScaleBegin = 0.74;
  static const Duration activityPopScaleDuration = Duration(milliseconds: 1000);

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------
  static const double headerBorderRadius = 24.0;
  static const double headerBorderWidth = 1.0;
  static const double headerGradientStartOpacity = 0.08;
  static const double headerGradientEndOpacity = 0.03;
  static const double headerBorderOpacity = 0.1;
  static const double headerTitleFontSizePercent = 0.032;
  static const double headerEmojiFontSizePercent = 0.03;
  static const double headerSpacingPercent = 0.012;
  static const double headerIconSpacingPercent = 0.02;
  static const double headerContainerPaddingPercent = 0.04;
  static const double headerButtonSpacingPercent = 0.03;
  static const Color headerBackgroundColor = Color(0xFFF5F2F8);

  // ---------------------------------------------------------------------------
  // Dropdown
  // ---------------------------------------------------------------------------
  static const double dropdownBorderRadius = 12.0;
  static const double dropdownMenuBorderRadius = 16.0;
  static const double dropdownBorderWidth = 1.0;
  static const double dropdownBorderOpacity = 0.1;
  static const double dropdownShadowBlur = 8.0;
  static const double dropdownShadowOffset = 2.0;
  static const double dropdownShadowOpacity = 0.05;
  static const double dropdownMaxHeight = 300.0;
  static const double dropdownItemVerticalPadding = 8.0;
  static const double dropdownHorizontalPadding = 16.0;

  // ---------------------------------------------------------------------------
  // Buttons & Responsive Layout
  // ---------------------------------------------------------------------------
  static const double buttonElevation = 4.0;
  static const double buttonBorderRadius = 16.0;
  static const double buttonMinHeight = 52.0;
  static const double responsivePaddingHorizontalPercent = 0.05;
  static const double responsiveSpacingHeightPercent = 0.03;
  static const double responsiveButtonSpacingPercent = 0.025;
  static const double responsiveButtonPaddingPercent = 0.02;

  // ---------------------------------------------------------------------------
  // Feedback / Alerts
  // ---------------------------------------------------------------------------
  static const double errorCardPadding = 16.0;
  static const double errorCardBorderRadius = 20.0;
  static const double errorCardBorderOpacity = 0.2;
  static const double errorCardBackgroundOpacity = 0.08;
  static const double errorCardIconGap = 12.0;

  // ---------------------------------------------------------------------------
  // Confetti
  // ---------------------------------------------------------------------------
  static const double confettiMinBlastForce = 6.0;
  static const double confettiMaxBlastForce = 18.0;
  static const double confettiEmissionFrequency = 0.035;
  static const double confettiGravity = 0.25;
  static const int confettiParticleCount = 10;

  // ---------------------------------------------------------------------------
  // Keys / Assets
  // ---------------------------------------------------------------------------
  static const String googleMapsApiKeyEnv = 'GOOGLE_MAPS_API_KEY';
  static const String unsplashApiKeyEnv = 'UNSPLASH_API_KEY';
  static const String soundAssetPath = 'sounds/star_sparkle.mp3';
}
