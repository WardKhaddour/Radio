import 'package:audio_service/audio_service.dart';
import '../services/background_audio_player.dart';

class Player {
  static Future<void> play(String name) async {
    print('start');
    if (AudioService.playbackState.playing) await AudioService.stop();
    print('waiting');
    await initAudioService();
    print('starting');
    AudioService.start(
      androidShowNotificationBadge: true,
      androidNotificationColor: 0xFF26A69A,
      androidNotificationChannelName: name,
      backgroundTaskEntrypoint: entrypoint,
      params: {'url': name},
    );
  }

  static Future<void> pause() async {
    await AudioService.pause();
  }

  static Future<void> stop() async {
    await AudioService.stop();
  }

  static Future<void> playMusic(String path) async {
    if (AudioService.playbackState.playing) await AudioService.stop();

    await initAudioService();
    AudioService.start(
        androidShowNotificationBadge: true,
        androidNotificationColor: 0xFF26A69A,
        androidNotificationChannelName: path.split('/').last.split('.').first,
        backgroundTaskEntrypoint: entrypoint,
        params: {'url': path});
  }
}
