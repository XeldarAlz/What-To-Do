import 'dart:convert';
import 'dart:collection';

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
  final _cache = LinkedHashMap<String, _PlacesCacheEntry>();

  void dispose() => _client.close();

  Future<List<PlaceSuggestion>> fetchNearby({
    required String query,
    required double latitude,
    required double longitude,
    int limit = 5,
    Duration cacheTtl = const Duration(minutes: 2),
  }) async {
    // Cache by coarse location to avoid repeated calls while the user
    // regenerates/sorts quickly from the same spot.
    final cacheKey =
        '$query|${latitude.toStringAsFixed(3)}|${longitude.toStringAsFixed(3)}|$limit';
    final cached = _cache[cacheKey];
    if (cached != null && !cached.isExpired(cacheTtl)) {
      return cached.places;
    }

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

    final parsed = results.take(limit).map((place) {
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

    _cache.remove(cacheKey);
    _cache[cacheKey] = _PlacesCacheEntry(places: parsed, createdAt: DateTime.now());
    if (_cache.length > 32) {
      _cache.remove(_cache.keys.first);
    }

    return parsed;
  }
}

class _PlacesCacheEntry {
  _PlacesCacheEntry({required this.places, required this.createdAt});

  final List<PlaceSuggestion> places;
  final DateTime createdAt;

  bool isExpired(Duration ttl) => DateTime.now().difference(createdAt) > ttl;
}

