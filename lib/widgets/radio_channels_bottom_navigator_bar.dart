import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/providers/player_provider.dart';
import '../services/player.dart';
import '../providers/channels_provider.dart';

class RadioChannelsBottomNavigatorBar extends StatefulWidget {
  @override
  _RadioChannelsBottomNavigatorBarState createState() =>
      _RadioChannelsBottomNavigatorBarState();
}

class _RadioChannelsBottomNavigatorBarState
    extends State<RadioChannelsBottomNavigatorBar> {
  bool playing = false;

  @override
  void initState() {
    isPlaying();

    super.initState();
  }

  void isPlaying() {
    AudioService.playbackStateStream.listen((PlaybackState state) {
      setState(() {
        playing = state.playing;
      });
    });
  }

  int _index = 0;
  void chooseType(int index) {
    if (index == 0) {
      Provider.of<ChannelsProvider>(context, listen: false).showAll();
    } else if (index == 1 && !playing) {
      Provider.of<ChannelsProvider>(context, listen: false).showFav();
    } else if (index == 2 && playing) {
      Provider.of<ChannelsProvider>(context, listen: false).showFav();
    }
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: chooseType,
      currentIndex: _index,
      items: [
        BottomNavigationBarItem(
          label: 'All',
          icon: Icon(
            Icons.all_out_rounded,
          ),
        ),
        if (playing)
          BottomNavigationBarItem(
            label: Provider.of<PlayerProvider>(context).currentChannel ?? '',
            icon: CircleAvatar(
              radius: 25,
              child: playing
                  ? IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: () async {
                        Player.play('');
                      })
                  : IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () async {
                        Player.play('');
                      }),
            ),
          ),
        BottomNavigationBarItem(
          label: 'Favorite',
          icon: Icon(
            Icons.favorite,
          ),
        ),
      ],
    );
  }
}
