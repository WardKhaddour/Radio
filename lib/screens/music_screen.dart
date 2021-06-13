import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../services/player.dart';
import '../providers/music_provider.dart';
import '../widgets/app_drawer.dart';

class MusicScreen extends StatefulWidget {
  static const routeName = '/music-screen';

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool _showSearchBar = false;
  List<File> _files = [];

  bool _playing = false;
  void isPlaying() {
    AudioService.playbackStateStream.listen((PlaybackState state) {
      setState(() {
        _playing = state.playing;
      });
      print('state playing $_playing}');
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      await Provider.of<MusicProvider>(context, listen: false).getFiles();
      _files = Provider.of<MusicProvider>(context, listen: false).files;
    });
    isPlaying();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   Future.delayed(Duration(seconds: 0)).then((value) async {
  //     await Provider.of<MusicProvider>(context, listen: false).getFiles();
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    _files = Provider.of<MusicProvider>(context).files;
    return Scaffold(
      appBar: AppBar(
        title: _showSearchBar
            ? TextField(
                onChanged: (value) {
                  _files =
                      Provider.of<MusicProvider>(context).searchFile(value);
                },
              )
            : Text('My Music'),
        actions: [
          _playing
              ? IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () async {
                    Player.playFromUrl('');
                  })
              : IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () async {
                    Player.playFromUrl('');
                  }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _showSearchBar = true;
                });
              }),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        color: Colors.teal,
        onRefresh: () async {
          await Provider.of<MusicProvider>(context, listen: false).getFiles();
        },
        child: _files == []
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Getting Files..."),
                  SizedBox(height: 20),
                  SpinKitChasingDots(
                    color: Colors.teal,
                  ),
                ],
              )
            : ListView.builder(
                itemCount: _files?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(_files[index].path.split('/').last),
                    leading: Icon(Icons.audiotrack),
                    trailing: Icon(
                      Icons.play_arrow,
                      color: Colors.teal,
                    ),
                    onTap: () {
                      Player.playFromStorage(_files[index].path);
                    },
                  ));
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Music',
            icon: IconButton(
              icon: Icon(Icons.audiotrack),
              onPressed: () {
                //TODO: toggle to music
              },
            ),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                //TODO: toggle to fav
              },
            ),
          ),
          BottomNavigationBarItem(
            label: 'Folders',
            icon: IconButton(
              icon: Icon(Icons.folder),
              onPressed: () {
                //TODO: toggle to folders
              },
            ),
          ),
        ],
      ),
    );
  }
}
