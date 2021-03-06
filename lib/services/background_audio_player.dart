import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

void entrypoint() => AudioServiceBackground.run(() => BackgroundAudioPlayer());

initAudioService() async {
  await AudioService.connect();
}

class BackgroundAudioPlayer extends BackgroundAudioTask {
  final _player = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.connecting);

    await _player.setUrl(params['url']);
    await _player.play();

    AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.ready);
    return super.onStart(params);
  }

  @override
  Future<void> onStop() async {
    AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.stopped);
    await _player.stop();
    return super.onStop();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.setState(
        controls: [MediaControl.play, MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.ready);
    await _player.pause();
    return super.onPause();
  }

  @override
  Future<void> onPlay() {
    AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.ready);
    _player.play();

    return super.onPlay();
  }
}
