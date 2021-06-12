import 'package:audio_service/audio_service.dart';
import '../services/background_audio_player.dart';

class Player {
  static Future<void> playFromUrl(String url) async {
    if (AudioService.playbackState.playing) await AudioService.stop();
    await initAudioService();
    AudioService.start(
        backgroundTaskEntrypoint: entrypoint, params: {'url': url});
  }

  static Future<void> playFromStorage(String path) async {
    if (AudioService.playbackState.playing) await AudioService.stop();
    await initAudioService();
    AudioService.start(
        backgroundTaskEntrypoint: entrypoint, params: {'url': path});
  }
}
