import 'package:flutter/cupertino.dart';

class PlayerProvider with ChangeNotifier {
  String _currentChannel;
  String _currentSong;

  String get currentChannel {
    return _currentChannel;
  }

  String get currentSong {
    return _currentSong;
  }

  void setCurrentChannel(String name) {
    _currentChannel = name;
    notifyListeners();
  }

  void setCurrentSong(String name) {
    _currentSong = name;
    notifyListeners();
  }
}
