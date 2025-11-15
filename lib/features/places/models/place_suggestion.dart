class PlaceSuggestion {
  const PlaceSuggestion({
    required this.name,
    required this.address,
    required this.placeId,
    required this.mapUrl,
    this.rating,
    this.userRatingsTotal,
    this.distanceText,
    this.distanceMeters,
  });

  final String name;
  final String address;
  final String placeId;
  final String mapUrl;
  final double? rating;
  final int? userRatingsTotal;
  final String? distanceText;
  final double? distanceMeters;
}

