import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:what_to_do_app/core/core.dart';
import 'package:what_to_do_app/features/activities/activities.dart';

class ActivityResultCard extends StatelessWidget {
  const ActivityResultCard({super.key, required this.activity, this.imageUrl});

  final Activity activity;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headlineSmall!;
    final emoji = activity.emoji ?? '✨';
    return Container(
      width: double.infinity,
      height: AppConstants.activityCardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.activityCardBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(
              alpha: AppConstants.activityCardShadowOpacity,
            ),
            blurRadius: AppConstants.activityCardShadowBlur,
            offset: const Offset(0, AppConstants.activityCardShadowOffset),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppConstants.activityCardBorderRadius,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                cacheWidth: 800,
                cacheHeight: 600,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.activityCardGradientStart,
                          AppConstants.activityCardGradientEnd,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  );
                },
              )
            else
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.activityCardGradientStart,
                      AppConstants.activityCardGradientEnd,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(
                      alpha:
                          AppConstants.activityCardGradientOverlayTopOpacity *
                          0.6,
                    ),
                    Colors.black.withValues(
                      alpha:
                          AppConstants
                              .activityCardGradientOverlayBottomOpacity *
                          0.75,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.activityCardPadding),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            AppConstants.activityCardBadgePaddingHorizontal,
                        vertical: AppConstants.activityCardBadgePaddingVertical,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: Colors.white.withValues(
                            alpha: AppConstants.activityCardBadgeBorderOpacity,
                          ),
                        ),
                      ),
                      child: Text(
                        emoji,
                        style: const TextStyle(
                          fontSize:
                              AppConstants.activityCardEmojiSize *
                              AppConstants.activityCardEmojiScale,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FractionallySizedBox(
                      widthFactor: AppConstants.activityCardInfoWidthFactor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: AppConstants.activityCardInfoBlurSigma,
                            sigmaY: AppConstants.activityCardInfoBlurSigma,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants
                                  .activityCardInfoPaddingHorizontal,
                              vertical:
                                  AppConstants.activityCardInfoPaddingVertical,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(
                                alpha: AppConstants
                                    .activityCardInfoBackgroundOpacity,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withValues(
                                  alpha: AppConstants
                                      .activityCardInfoBorderOpacity,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  activity.label,
                                  style: titleStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                    fontSize: titleStyle.fontSize != null
                                        ? titleStyle.fontSize! - 2
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
