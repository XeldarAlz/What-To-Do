import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:what_to_do_app/core/core.dart';
import 'package:what_to_do_app/features/activities/activities.dart';
import 'package:what_to_do_app/features/audio/audio.dart';
import 'package:what_to_do_app/features/home/utils/activity_generator.dart';
import 'package:what_to_do_app/features/home/widgets/activity_result_card.dart';
import 'package:what_to_do_app/features/home/widgets/place_result_tile.dart';
import 'package:what_to_do_app/features/location/location.dart';
import 'package:what_to_do_app/features/places/places.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _locationService = const LocationService();
  final _activityRepository = ActivityRepository();
  final _messageRepository = MessageRepository();
  late final PlacesRepository _placesRepository;
  late final UnsplashService _unsplashService;
  late final ConfettiController _confettiController;
  late final SoundService _soundService;
  late final ActivityGenerator _activityGenerator;

  Position? _currentPosition;
  Activity? _currentActivity;
  String? _currentMessage;
  String? _currentImageUrl;
  List<PlaceSuggestion> _allPlaces = const [];
  List<PlaceSuggestion> _visiblePlaces = const [];
  int _visibleCount = 0;
  PlaceSortOption _sortOption = PlaceSortOption.distance;

  bool _isRequestingLocation = false;
  bool _isGeneratingActivity = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: AppConstants.confettiDuration,
    );
    _placesRepository = PlacesRepository(
      apiKey: const String.fromEnvironment(AppConstants.googleMapsApiKeyEnv),
    );
    _unsplashService = UnsplashService(
      apiKey: const String.fromEnvironment(AppConstants.unsplashApiKeyEnv),
    );
    _soundService = SoundService();
    _activityGenerator = ActivityGenerator(
      activityRepository: _activityRepository,
      messageRepository: _messageRepository,
      unsplashService: _unsplashService,
      placesRepository: _placesRepository,
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _soundService.dispose();
    _placesRepository.dispose();
    _unsplashService.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    if (_isRequestingLocation) return;

    setState(() {
      _isRequestingLocation = true;
      _error = null;
    });

    try {
      final position = await _locationService.determinePosition();
      setState(() {
        _currentPosition = position;
      });
    } on LocationException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      const message = 'Konum alınırken bir sorun oluştu.';
      setState(() => _error = message);
    } finally {
      if (mounted) {
        setState(() => _isRequestingLocation = false);
      }
    }
  }

  Future<void> _generateActivity() async {
    if (_currentPosition == null || _isGeneratingActivity) {
      if (_currentPosition == null) {
        setState(() => _error = 'Önce konum izni vermelisin.');
      }
      return;
    }

    if (_placesRepository.apiKey.isEmpty) {
      setState(() {
        _error =
            'Google Maps API anahtarı tanımlanmadı. '
            '--dart-define=${AppConstants.googleMapsApiKeyEnv}=ANAHTAR '
            'şeklinde çalıştırın.';
      });
      return;
    }

    _confettiController.stop();

    setState(() {
      _isGeneratingActivity = true;
      _currentActivity = null;
      _currentMessage = null;
      _currentImageUrl = null;
      _allPlaces = const [];
      _visiblePlaces = const [];
      _visibleCount = 0;
      _error = null;
    });

    try {
      // Keep the spinner visible briefly to avoid a “flash” on fast networks,
      // but don't add a fixed delay to every request.
      final stopwatch = Stopwatch()..start();
      final result = await _activityGenerator.generate(_currentPosition!);

      if (!mounted) return;

      final elapsed = stopwatch.elapsed;
      const minSpinner = Duration(milliseconds: 250);
      if (elapsed < minSpinner) {
        await Future<void>.delayed(minSpinner - elapsed);
        if (!mounted) return;
      }

      if (result.imageUrl != null) {
        // Warm the image cache without blocking UI updates.
        unawaited(precacheImage(NetworkImage(result.imageUrl!), context));
      }

      final sortedPlaces = PlacesSorter.sort(result.places, _sortOption);
      final initialCount =
          sortedPlaces.length < AppConstants.initialPlacesPageSize
          ? sortedPlaces.length
          : AppConstants.initialPlacesPageSize;

      setState(() {
        _currentActivity = result.activity;
        _currentMessage = result.message;
        _currentImageUrl = result.imageUrl;
        _allPlaces = sortedPlaces;
        _visibleCount = initialCount;
        _visiblePlaces = sortedPlaces.take(initialCount).toList();
        _isGeneratingActivity = false;
      });

      if (result.places.isNotEmpty) {
        _confettiController.play();
        HapticFeedback.lightImpact();
        _soundService.playSuccessSound();
      }
    } on PlacesException catch (e) {
      setState(() {
        _isGeneratingActivity = false;
        _error = e.message;
        _allPlaces = const [];
        _visiblePlaces = const [];
        _visibleCount = 0;
      });
    } catch (_) {
      const message = 'Aktivite aranırken hata oluştu.';
      setState(() {
        _isGeneratingActivity = false;
        _error = message;
        _allPlaces = const [];
        _visiblePlaces = const [];
        _visibleCount = 0;
      });
    }
  }

  void _loadMorePlaces() {
    if (_isGeneratingActivity || _visibleCount >= _allPlaces.length) {
      return;
    }

    final maxCount = _allPlaces.length;
    final nextCount =
        (_visibleCount + AppConstants.initialPlacesPageSize) > maxCount
        ? maxCount
        : _visibleCount + AppConstants.initialPlacesPageSize;

    setState(() {
      _visibleCount = nextCount;
      _visiblePlaces = _allPlaces.take(_visibleCount).toList();
    });
  }

  void _onSortChanged(PlaceSortOption? option) {
    if (option == null || option == _sortOption || _allPlaces.isEmpty) {
      return;
    }

    setState(() {
      _sortOption = option;
      _allPlaces = PlacesSorter.sort(_allPlaces, _sortOption);
      if (_visibleCount > _allPlaces.length) {
        _visibleCount = _allPlaces.length;
      }
      _visiblePlaces = _allPlaces.take(_visibleCount).toList();
    });
  }

  Widget _buildPlacesContent() {
    if (_isGeneratingActivity) {
      return const SizedBox(key: ValueKey('loading-placeholder'));
    }

    if (_visiblePlaces.isEmpty && _currentActivity != null) {
      return const _EmptyState(key: ValueKey('empty'));
    }

    if (_visiblePlaces.isEmpty) {
      return const SizedBox(key: ValueKey('idle'));
    }

    return Column(
      key: ValueKey(
        'list-${_sortOption.name}-$_visibleCount-${_allPlaces.length}',
      ),
      children: [
        ..._visiblePlaces.map(
          (place) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PlaceResultTile(
              suggestion: place,
              onTap: () => _openMaps(place),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: OutlinedButton(
            onPressed:
                _isGeneratingActivity || _visibleCount >= _allPlaces.length
                ? null
                : _loadMorePlaces,
            child: Text(
              _visibleCount >= _allPlaces.length
                  ? 'Hepsi gösterildi'
                  : 'Daha fazlası',
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openMaps(PlaceSuggestion place) async {
    final uri = Uri.parse(place.mapUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      setState(() => _error = 'Google Maps açılamadı.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal:
                    screenSize.width *
                    AppConstants.responsivePaddingHorizontalPercent,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(
                    hasLocation: _currentPosition != null,
                    onRequestLocation: _getLocation,
                    isLoading: _isRequestingLocation,
                    subtitle: _currentMessage,
                  ),
                  if (_currentPosition != null) ...[
                    SizedBox(
                      height:
                          screenSize.height *
                          AppConstants.responsiveSpacingHeightPercent,
                    ),
                    _ActivitySection(
                      isGenerating: _isGeneratingActivity,
                      activity: _currentActivity,
                      imageUrl: _currentImageUrl,
                    ),
                    SizedBox(
                      height:
                          screenSize.height *
                          AppConstants.responsiveButtonSpacingPercent,
                    ),
                  ] else
                    const SizedBox(height: 24),
                  if (_currentPosition != null)
                    ElevatedButton(
                      onPressed: _isGeneratingActivity
                          ? null
                          : _generateActivity,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              screenSize.height *
                              AppConstants.responsiveButtonPaddingPercent,
                        ),
                        elevation: AppConstants.buttonElevation,
                      ),
                      child: Text(
                        _currentActivity == null
                            ? 'Ne yapalım?'
                            : 'Yeni bir aktivite',
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: _isRequestingLocation ? null : _getLocation,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              screenSize.height *
                              AppConstants.responsiveButtonPaddingPercent,
                        ),
                        elevation: AppConstants.buttonElevation,
                      ),
                      child: const Text('Konum izni ver'),
                    ),
                  SizedBox(
                    height:
                        screenSize.height *
                        AppConstants.responsiveButtonSpacingPercent,
                  ),
                  if (_currentActivity != null)
                    Text(
                      'Aktiviteye bağlı yerler',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (_allPlaces.isNotEmpty) _buildSortDropdown(theme),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildPlacesContent(),
                  ),
                  if (_error != null) _buildErrorDisplay(theme),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: RepaintBoundary(
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: AppConstants.confettiMaxBlastForce,
                  minBlastForce: AppConstants.confettiMinBlastForce,
                  emissionFrequency: AppConstants.confettiEmissionFrequency,
                  numberOfParticles: AppConstants.confettiParticleCount,
                  gravity: AppConstants.confettiGravity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorDisplay(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.errorCardPadding),
        decoration: BoxDecoration(
          color: theme.colorScheme.error.withValues(
            alpha: AppConstants.errorCardBackgroundOpacity,
          ),
          borderRadius: BorderRadius.circular(
            AppConstants.errorCardBorderRadius,
          ),
          border: Border.all(
            color: theme.colorScheme.error.withValues(
              alpha: AppConstants.errorCardBorderOpacity,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: theme.colorScheme.error),
            const SizedBox(width: AppConstants.errorCardIconGap),
            Expanded(
              child: Text(
                _error!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortDropdown(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.sort, size: 20),
          const SizedBox(width: 8),
          Text(
            'Sırala:',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.dropdownHorizontalPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppConstants.dropdownBorderRadius,
                ),
                border: Border.all(
                  color: Colors.black.withValues(
                    alpha: AppConstants.dropdownBorderOpacity,
                  ),
                  width: AppConstants.dropdownBorderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: AppConstants.dropdownShadowOpacity,
                    ),
                    blurRadius: AppConstants.dropdownShadowBlur,
                    offset: const Offset(0, AppConstants.dropdownShadowOffset),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<PlaceSortOption>(
                  isExpanded: true,
                  value: _sortOption,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.colorScheme.primary,
                  ),
                  iconSize: 24,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppConstants.dropdownMenuBorderRadius,
                  ),
                  menuMaxHeight: AppConstants.dropdownMaxHeight,
                  items: PlaceSortOption.values
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical:
                                  AppConstants.dropdownItemVerticalPadding,
                            ),
                            child: Text(PlacesSorter.getLabel(option)),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: _isGeneratingActivity ? null : _onSortChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.hasLocation,
    required this.onRequestLocation,
    required this.isLoading,
    required this.subtitle,
  });

  final bool hasLocation;
  final bool isLoading;
  final String? subtitle;
  final VoidCallback onRequestLocation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(
        screenSize.width * AppConstants.headerContainerPaddingPercent,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(
              alpha: AppConstants.headerGradientStartOpacity,
            ),
            theme.colorScheme.primary.withValues(
              alpha: AppConstants.headerGradientEndOpacity,
            ),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.headerBorderRadius),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(
            alpha: AppConstants.headerBorderOpacity,
          ),
          width: AppConstants.headerBorderWidth,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withValues(alpha: 0.7),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'Bugün ne yapsak?',
                    style: TextStyle(
                      fontSize:
                          screenSize.height *
                          AppConstants.headerTitleFontSizePercent,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * AppConstants.headerSpacingPercent,
                ),
                if (!hasLocation)
                  Text(
                    'Konumunu alalım, sana yakın öneriler sunalım. 📍',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: context.textPrimary,
                      height: 1.4,
                    ),
                  )
                else
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      subtitle ?? 'Harika önerilerimiz var!',
                      key: ValueKey(subtitle ?? 'default'),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: screenSize.width * AppConstants.headerButtonSpacingPercent,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton.filledTonal(
              onPressed: isLoading ? null : onRequestLocation,
              icon: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : Icon(
                      hasLocation
                          ? Icons.my_location
                          : Icons.location_searching,
                      color: theme.colorScheme.primary,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivitySection extends StatelessWidget {
  const _ActivitySection({
    required this.isGenerating,
    required this.activity,
    this.imageUrl,
  });

  final bool isGenerating;
  final Activity? activity;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (isGenerating) {
      return const _LoadingCard(text: 'İlham aranıyor...');
    }

    if (activity == null) {
      return const _PlaceholderCard();
    }

    final highlightKey = ValueKey(
      '${activity!.label}-${activity!.emoji ?? ''}',
    );

    final highlightedCard = TweenAnimationBuilder<double>(
      key: highlightKey,
      tween: Tween(begin: 1.0, end: 0.0),
      duration: AppConstants.activityHighlightDuration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (value > 0)
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppConstants.activityCardBorderRadius +
                            AppConstants.activityHighlightBorderRadiusOffset,
                      ),
                      border: Border.all(
                        color: AppConstants.activityHighlightColor.withOpacity(
                          0.6 * value,
                        ),
                        width:
                            AppConstants.activityHighlightBorderWidth * value,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppConstants.activityHighlightColor
                              .withOpacity(0.35 * value),
                          blurRadius:
                              AppConstants.activityHighlightMaxBlur * value,
                          spreadRadius:
                              AppConstants.activityHighlightMaxSpread * value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            child!,
          ],
        );
      },
      child: ActivityResultCard(activity: activity!, imageUrl: imageUrl),
    );

    return TweenAnimationBuilder<double>(
      key: ValueKey('pop-${activity!.label}-${activity!.emoji ?? ''}'),
      tween: Tween(begin: AppConstants.activityPopScaleBegin, end: 1.0),
      duration: AppConstants.activityPopScaleDuration,
      curve: Curves.easeOutBack,
      child: highlightedCard,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  const _PlaceholderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hazır olduğunda butona dokun!',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Senin için rastgele aktiviteler oluşturacağız.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(strokeWidth: 4),
          ),
          const SizedBox(height: 16),
          Text(text, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Yakınlarda sonuç bulamadık.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Butona basarak farklı aktiviteleri deneyebilirsin.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
