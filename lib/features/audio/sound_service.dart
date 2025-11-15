import 'package:audioplayers/audioplayers.dart';
import 'package:what_to_do_app/core/constants/app_constants.dart';

class SoundService {
  SoundService() : _player = AudioPlayer();

  final AudioPlayer _player;

  Future<void> playSuccessSound() async {
    try {
      await _player.play(AssetSource(AppConstants.soundAssetPath));
    } catch (_) {
      // Silently fail if sound file doesn't exist
    }
  }

  void dispose() {
    _player.dispose();
  }
}
