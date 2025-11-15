import 'package:geolocator/geolocator.dart';

class LocationException implements Exception {
  const LocationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class LocationService {
  const LocationService();

  Future<Position> determinePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(
        'Konum servisleri kapalı. Lütfen cihaz ayarlarından açın.',
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException('Konum izni olmadan devam edemiyoruz.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
        'Konum izni kalıcı olarak reddedildi. Ayarlar > Gizlilik > Konum yolundan izin verebilirsin.',
      );
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
