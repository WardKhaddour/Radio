import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/providers/player_provider.dart';
// import '../screens/player.dart' as playerScreen;
import '../services/player.dart';
import '../providers/music_provider.dart';
import '../widgets/background.dart';

class MusicView extends StatefulWidget {
  @override
  _MusicViewState createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  List<File> _music = [];
  @override
  void initState() {
    _music = Provider.of<MusicProvider>(context, listen: false).files;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MusicProvider>(context);
    if (Provider.of<MusicProvider>(context).activeSearch)
      _music = prov.searchResult;
    else {
      _music = prov.files;
    }
    return BackGround(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: _music.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  _music[index]
                      .path
                      .split('/')
                      .last
                      .toString()
                      .split('.')
                      .first,
                ),
                leading: Icon(Icons.audiotrack),
                onTap: () {
                  Player.play(_music[index].path);
                  Provider.of<PlayerProvider>(context, listen: false)
                      .setCurrentSong(
                    _music[index]
                        .path
                        .split('/')
                        .last
                        .toString()
                        .split('.')
                        .first,
                  );
                  // Navigator.of(context)
                  //     .pushNamed(playerScreen.Player.routeName);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
