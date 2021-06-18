import 'package:audio_service/audio_service.dart';
import '../services/background_audio_player.dart';

class Player {
  static Future<void> play(String name) async {
    if (AudioService.playbackState.playing) await AudioService.stop();
    await initAudioService();
    AudioService.start(
      backgroundTaskEntrypoint: entrypoint,
      params: {'url': name},
    );
  }

  static Future<void> playMusic(String path) async {
    if (AudioService.playbackState.playing) await AudioService.stop();

    await initAudioService();
    AudioService.start(
        backgroundTaskEntrypoint: entrypoint, params: {'url': path});
  }
//   static Future<void> pauseMusic()async{
// await AudioService.pause();
//   }
//   static Future<void> stopMusic()async{
// await AudioService.stop();
//   }

}
