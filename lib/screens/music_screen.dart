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
  List<File> _files = [];
  List _searchResult = [];
  bool _playing = false;
  bool _activeSearch = false;
  String _searchName = ' ';
  void isPlaying() {
    AudioService.playbackStateStream.listen((PlaybackState state) {
      setState(() {
        _playing = state.playing;
      });
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

  @override
  void didChangeDependencies() {
    _files = Provider.of<MusicProvider>(context, listen: false).files;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build music screen');
    final prov = Provider.of<MusicProvider>(context);
    // if (_searchResult.isNotEmpty || _activeSearch)
    //   _files = _searchResult;
    // else
    _files = prov.files;
    final fs = prov.directory;
    return Scaffold(
      appBar: AppBar(
        title: _activeSearch
            ? TextField(
                autofocus: true,
                onChanged: (value) {
                  _searchName = value;
                  setState(() {
                    _searchResult = prov.searchFile(_searchName);
                  });
                },
              )
            : Text('My Music'),
        actions: [
          !_activeSearch
              ? _playing
                  ? IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: () async {
                        Player.play('');
                      })
                  : IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () async {
                        Player.play('');
                      })
              : SizedBox(),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _activeSearch = true;
                });
              }),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: fs.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Provider.of<MusicProvider>(context, listen: false)
                      .getFilesFromDirectory(fs[index]);
                },
                title: Text(
                  prov.files[index].toString().split('/').last,
                ),
                leading: Icon(Icons.folder),
              ),
            );
          }),
      // body: RefreshIndicator(
      //   color: Theme.of(context).primaryColor,
      //   onRefresh: () async {
      //     await Provider.of<MusicProvider>(context, listen: false).getFiles();
      //   },
      //   child: _files == []
      //       ? Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Text("Getting Files..."),
      //             SizedBox(height: 20),
      //             SpinKitChasingDots(
      //               color: Theme.of(context).primaryColor,
      //             ),
      //           ],
      //         )
      //       : Scrollbar(
      //           child: ListView.builder(
      //             itemCount: _files?.length ?? 0,
      //             itemBuilder: (context, index) {
      //               return Card(
      //                   child: ListTile(
      //                 title: Text(_files[index].path.split('/').last),
      //                 leading: Icon(Icons.audiotrack),
      //                 trailing: Icon(
      //                   Icons.play_arrow,
      //                   color: Theme.of(context).primaryColor,
      //                 ),
      //                 onTap: () {
      //                   Player.play(_files[index].path);
      //                 },
      //               ));
      //             },
      //           ),
      //         ),
      // ),
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
