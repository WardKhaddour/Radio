import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import '../constatnts.dart';
import '../services/player.dart' as player;

class Player extends StatelessWidget {
  static const routeName = '/player';
  final String imageURL;
  final String songName;
  final String url;
  Player({this.imageURL, this.songName, this.url});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: FadeInImage(
              placeholder: AssetImage(cd),
              image: NetworkImage(imageURL),
            ),
          ),
          Text(songName),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.shuffle),
                  onPressed: () {
                    // AudioService.setShuffleMode(AudioServiceShuffleMode.all);
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
                    Icons.pause,
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
              IconButton(icon: Icon(Icons.repeat), onPressed: () {}),
            ],
          ),
        ]),
      ),
    );
  }
}
