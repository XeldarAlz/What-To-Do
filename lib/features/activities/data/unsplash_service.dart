import 'dart:convert';
import 'dart:collection';

import 'package:http/http.dart' as http;

class UnsplashException implements Exception {
  const UnsplashException(this.message);
  final String message;

  @override
  String toString() => message;
}

class UnsplashService {
  UnsplashService({required this.apiKey, http.Client? client})
      : _client = client ?? http.Client();

  final String apiKey;
  final http.Client _client;
  final _cache = LinkedHashMap<String, _UnsplashCacheEntry>();

  void dispose() => _client.close();

  Future<String> getImageUrl({
    required String query,
    int width = 800,
    int height = 600,
    Duration cacheTtl = const Duration(minutes: 2),
  }) async {
    if (apiKey.isEmpty) {
      throw const UnsplashException('Unsplash API key is required');
    }

    final cached = _cache[query];
    if (cached != null && !cached.isExpired(cacheTtl)) {
      return cached.url;
    }

    final uri = Uri.https(
      'api.unsplash.com',
      '/photos/random',
      <String, String>{
        'query': query,
        'orientation': 'landscape',
        'w': width.toString(),
        'h': height.toString(),
        'client_id': apiKey,
      },
    );

    try {
      final response = await _client.get(uri).timeout(
            const Duration(seconds: 5),
          );

      if (response.statusCode != 200) {
        throw UnsplashException(
          'Unsplash API request failed (${response.statusCode})',
        );
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final urls = decoded['urls'] as Map<String, dynamic>?;
      final regularUrl = urls?['regular'] as String?;

      if (regularUrl == null) {
        throw const UnsplashException('No image URL found in response');
      }

      _cache.remove(query);
      _cache[query] = _UnsplashCacheEntry(url: regularUrl, createdAt: DateTime.now());
      if (_cache.length > 32) {
        _cache.remove(_cache.keys.first);
      }

      return regularUrl;
    } on http.ClientException {
      throw const UnsplashException('Network error: Unable to reach Unsplash API');
    } catch (e) {
      if (e is UnsplashException) rethrow;
      throw UnsplashException('Failed to fetch image: ${e.toString()}');
    }
  }
}

class _UnsplashCacheEntry {
  _UnsplashCacheEntry({required this.url, required this.createdAt});

  final String url;
  final DateTime createdAt;

  bool isExpired(Duration ttl) => DateTime.now().difference(createdAt) > ttl;
}

