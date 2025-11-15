import 'package:what_to_do_app/features/places/models/place_suggestion.dart';

enum PlaceSortOption { distance, rating, reviews }

class PlacesSorter {
  PlacesSorter._();

  static List<PlaceSuggestion> sort(
    List<PlaceSuggestion> places,
    PlaceSortOption option,
  ) {
    final sortedList = List<PlaceSuggestion>.from(places);

    switch (option) {
      case PlaceSortOption.distance:
        sortedList.sort(_compareByDistance);
        break;
      case PlaceSortOption.rating:
        sortedList.sort(_compareByRating);
        break;
      case PlaceSortOption.reviews:
        sortedList.sort(_compareByReviews);
        break;
    }

    return sortedList;
  }

  static int _compareByDistance(PlaceSuggestion a, PlaceSuggestion b) {
    final aDistance = a.distanceMeters ?? double.infinity;
    final bDistance = b.distanceMeters ?? double.infinity;
    return aDistance.compareTo(bDistance);
  }

  static int _compareByRating(PlaceSuggestion a, PlaceSuggestion b) {
    final aRating = a.rating ?? 0;
    final bRating = b.rating ?? 0;
    final ratingCompare = bRating.compareTo(aRating);

    if (ratingCompare != 0) return ratingCompare;

    return (b.userRatingsTotal ?? 0).compareTo(a.userRatingsTotal ?? 0);
  }

  static int _compareByReviews(PlaceSuggestion a, PlaceSuggestion b) {
    final aReviews = a.userRatingsTotal ?? 0;
    final bReviews = b.userRatingsTotal ?? 0;
    final reviewCompare = bReviews.compareTo(aReviews);

    if (reviewCompare != 0) return reviewCompare;

    return (b.rating ?? 0).compareTo(a.rating ?? 0);
  }

  static String getLabel(PlaceSortOption option) {
    switch (option) {
      case PlaceSortOption.distance:
        return 'Yakınlığa göre';
      case PlaceSortOption.rating:
        return 'Yıldız puanına göre';
      case PlaceSortOption.reviews:
        return 'Yorum sayısına göre';
    }
  }
}
