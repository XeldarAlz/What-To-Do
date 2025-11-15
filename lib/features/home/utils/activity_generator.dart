import 'package:geolocator/geolocator.dart';
import 'package:what_to_do_app/core/core.dart';
import 'package:what_to_do_app/features/activities/activities.dart';
import 'package:what_to_do_app/features/places/places.dart';

class ActivityGeneratorResult {
  const ActivityGeneratorResult({
    required this.activity,
    required this.message,
    required this.imageUrl,
    required this.places,
  });

  final Activity activity;
  final String message;
  final String? imageUrl;
  final List<PlaceSuggestion> places;
}

class ActivityGenerator {
  ActivityGenerator({
    required ActivityRepository activityRepository,
    required MessageRepository messageRepository,
    required UnsplashService unsplashService,
    required PlacesRepository placesRepository,
  })  : _activityRepository = activityRepository,
        _messageRepository = messageRepository,
        _unsplashService = unsplashService,
        _placesRepository = placesRepository;

  final ActivityRepository _activityRepository;
  final MessageRepository _messageRepository;
  final UnsplashService _unsplashService;
  final PlacesRepository _placesRepository;

  Future<ActivityGeneratorResult> generate(
    Position position,
  ) async {
    final activity = _activityRepository.nextActivity;
    final message = _messageRepository.nextMessage;

    String? imageUrl;
    try {
      imageUrl = await _unsplashService.getImageUrl(
        query: activity.imageSearchQuery,
      );
      await _unsplashService.preloadImage(imageUrl);
    } catch (_) {
      imageUrl = null;
    }

    final places = await _placesRepository.fetchNearby(
      query: activity.query,
      latitude: position.latitude,
      longitude: position.longitude,
      limit: AppConstants.maxPlacesToFetch,
    );

    return ActivityGeneratorResult(
      activity: activity,
      message: message,
      imageUrl: imageUrl,
      places: places,
    );
  }
}

