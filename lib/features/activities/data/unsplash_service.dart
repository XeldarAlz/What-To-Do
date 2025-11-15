import 'dart:convert';
import 'dart:io';

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

  Future<String> getImageUrl({
    required String query,
    int width = 800,
    int height = 600,
  }) async {
    if (apiKey.isEmpty) {
      throw const UnsplashException('Unsplash API key is required');
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

      return regularUrl;
    } on SocketException {
      throw const UnsplashException('Network error: Check your internet connection');
    } on http.ClientException {
      throw const UnsplashException('Network error: Unable to reach Unsplash API');
    } catch (e) {
      if (e is UnsplashException) rethrow;
      throw UnsplashException('Failed to fetch image: ${e.toString()}');
    }
  }

  Future<bool> preloadImage(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);
      final client = HttpClient();
      try {
        final request = await client.getUrl(uri);
        request.followRedirects = true;
        final response = await request.close().timeout(
              const Duration(seconds: 5),
            );
        return response.statusCode == 200;
      } finally {
        client.close();
      }
    } catch (_) {
      return false;
    }
  }
}

