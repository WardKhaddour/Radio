import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/providers/player_provider.dart';
import '../widgets/background.dart';
import '../widgets/scrolling_text.dart';
import '../constatnts.dart';
import '../services/player.dart' as player;
import '../screens/music_screen.dart';

class Player extends StatefulWidget {
  static const routeName = '/player';

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool _isPlaying;

  @override
  Widget build(BuildContext context) {
    _isPlaying = AudioService.playbackState.playing;
    String songName = Provider.of<PlayerProvider>(context).currentSong;
    return SafeArea(
      child: Dismissible(
        key: Key('player_screen'),
        direction: DismissDirection.vertical,
        onDismissed: (_) => Navigator.of(context).pop(),
        background: MusicScreen(),
        child: Scaffold(
          body: BackGround(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(
                flex: 4,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image(
                    image: AssetImage(cd),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: ScrollingText(
                  text: songName ?? "",
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.shuffle),
                      onPressed: () {
                        AudioService.setShuffleMode(
                            AudioServiceShuffleMode.all);
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        size: 40,
                      ),
                      onPressed: () {
                        AudioService.skipToPrevious();
                      }),
                  IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                      ),
                      onPressed: () {
                        player.Player.playMusic('');
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        size: 40,
                      ),
                      onPressed: () {
                        AudioService.skipToNext();
                      }),
                  IconButton(
                      icon: Icon(Icons.repeat),
                      onPressed: () {
                        AudioService.setRepeatMode(AudioServiceRepeatMode.all);
                      }),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
