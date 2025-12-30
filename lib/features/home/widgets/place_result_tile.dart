import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:what_to_do_app/core/core.dart';
import 'package:what_to_do_app/features/places/places.dart';

class PlaceResultTile extends StatelessWidget {
  const PlaceResultTile({
    super.key,
    required this.suggestion,
    required this.onTap,
  });

  final PlaceSuggestion suggestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(20);
    final decoration = BoxDecoration(
      color: context.cardBackground,
      borderRadius: borderRadius,
      border: Border.all(color: context.borderColor),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.04),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    );

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: decoration,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            onTap();
          },
          borderRadius: borderRadius,
          splashFactory: InkSparkle.splashFactory,
          overlayColor: WidgetStateProperty.resolveWith((states) {
            final base = theme.colorScheme.primary;
            if (states.contains(WidgetState.pressed)) {
              return base.withValues(alpha: 0.10);
            }
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return base.withValues(alpha: 0.06);
            }
            return null;
          }),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    suggestion.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (suggestion.rating != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          suggestion.rating!.toStringAsFixed(1),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              suggestion.address,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.textSecondary,
              ),
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                if (suggestion.distanceText != null)
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 18,
                        color: context.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        suggestion.distanceText!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                if (suggestion.distanceText != null &&
                    suggestion.userRatingsTotal != null)
                  const SizedBox(width: 12),
                if (suggestion.userRatingsTotal != null)
                  Row(
                    children: [
                      Icon(
                        Icons.mode_comment_outlined,
                        size: 18,
                        color: context.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${suggestion.userRatingsTotal}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                Text(
                  'Detaya git',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ],
            ),
          ),
        ),
      ),
    );
  }
}
