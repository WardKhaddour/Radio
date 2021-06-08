import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class PlayerProvider with ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();
  String _currentChannel;
  void setCurrentChannel(String name) {
    _currentChannel = name;
    notifyListeners();
  }

  String get currentChannel {
    return _currentChannel;
  }

  bool isPlaying() {
    return _audioPlayer.playing;
  }

  Future<void> play() async {
    await pause();
    await _audioPlayer.play();
    notifyListeners();
  }

  Future<void> setPath(String path) async {
    await _audioPlayer.setFilePath(path);
    play();
  }

  Future<void> setURL(String url) async {
    await pause();
    await _audioPlayer.setUrl(url);
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    notifyListeners();
  }
}
