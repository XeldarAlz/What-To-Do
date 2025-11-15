import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:what_to_do_app/features/places/models/place_suggestion.dart';

class PlacesException implements Exception {
  const PlacesException(this.message);
  final String message;

  @override
  String toString() => message;
}

class PlacesRepository {
  PlacesRepository({
    required this.apiKey,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String apiKey;
  final http.Client _client;

  Future<List<PlaceSuggestion>> fetchNearby({
    required String query,
    required double latitude,
    required double longitude,
    int limit = 5,
  }) async {
    final uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/textsearch/json',
      <String, String>{
        'query': query,
        'location': '$latitude,$longitude',
        'radius': '5000',
        'language': 'tr',
        'key': apiKey,
      },
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw PlacesException(
        'Google Places isteği başarısız oldu (${response.statusCode}).',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final status = decoded['status'] as String?;

    if (status == 'REQUEST_DENIED' || status == 'INVALID_REQUEST') {
      throw PlacesException(
        decoded['error_message'] as String? ??
            'Google Places isteği reddedildi ($status).',
      );
    }

    final results = (decoded['results'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();

    return results.take(limit).map((place) {
      final geometry = place['geometry'] as Map<String, dynamic>?;
      final location = geometry?['location'] as Map<String, dynamic>? ?? {};
      final lat = (location['lat'] as num?)?.toDouble();
      final lng = (location['lng'] as num?)?.toDouble();

      String? distanceText;
      double? distanceMeters;
      if (lat != null && lng != null) {
        final distance = Geolocator.distanceBetween(
          latitude,
          longitude,
          lat,
          lng,
        );
        distanceMeters = distance;
        distanceText = distance >= 1000
            ? '${(distance / 1000).toStringAsFixed(1)} km'
            : '${distance.toStringAsFixed(0)} m';
      }

      final name = place['name'] as String? ?? 'Bilinmeyen mekan';
      final placeId = place['place_id'] as String? ?? '';

      final url = Uri.https(
        'www.google.com',
        '/maps/search/',
        <String, String>{
          'api': '1',
          'query': name,
          if (placeId.isNotEmpty) 'query_place_id': placeId,
        },
      ).toString();

      return PlaceSuggestion(
        name: name,
        address: place['formatted_address'] as String? ?? 'Adres bilgisi yok',
        placeId: placeId,
        rating: (place['rating'] as num?)?.toDouble(),
        userRatingsTotal: place['user_ratings_total'] as int?,
        distanceText: distanceText,
        distanceMeters: distanceMeters,
        mapUrl: url,
      );
    }).toList();
  }
}

