import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../services/player.dart';
import '../providers/music_provider.dart';
import '../widgets/app_drawer.dart';

enum viewType {
  Music,
  Folders,
  Favorites,
}

class MusicScreen extends StatefulWidget {
  static const routeName = '/music-screen';

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  List _shownFiles = [];
  bool _playing = false;
  bool _activeSearch = false;
  String _viewType = describeEnum(viewType.Music);
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
    });
    isPlaying();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  int _index = 0;
  void chooseType(int index) {
    if (index == 0) {
      if (_viewType == describeEnum(viewType.Music)) {
        return;
      }
      setState(() {
        _viewType = describeEnum(viewType.Music);
      });
    } else if (index == 1) {
      if (_viewType == describeEnum(viewType.Folders)) {
        return;
      }
      setState(() {
        _viewType = describeEnum(viewType.Folders);
      });
    }
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build music screen');
    final prov = Provider.of<MusicProvider>(context);
    _viewType == describeEnum(viewType.Music)
        ? _shownFiles = prov.files
        : _shownFiles = prov.directory;

    return Scaffold(
      appBar: AppBar(
        title: _activeSearch
            ? TextField(
                autofocus: true,
                // onChanged: (value) {
                //   _searchName = value;
                //   setState(() {
                //     _searchResult = prov.searchFile(_searchName);
                //   });
                // },
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
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          await Provider.of<MusicProvider>(context, listen: false).getFiles();
        },
        child: _shownFiles == []
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Getting Files..."),
                  SizedBox(height: 20),
                  SpinKitChasingDots(
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              )
            : Scrollbar(
                child: ListView.builder(
                  itemCount: _shownFiles?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                        color: _viewType == describeEnum(viewType.Music)
                            ? Colors.white
                            : Colors.grey.shade100,
                        child: ListTile(
                          title: Text(_viewType == describeEnum(viewType.Music)
                              ? _shownFiles[index]
                                  .path
                                  .split('/')
                                  .last
                                  .toString()
                                  .split('.')
                                  .first
                              : _shownFiles[index].path.split('/').last),
                          leading: Icon(
                              _viewType == describeEnum(viewType.Music)
                                  ? Icons.audiotrack
                                  : Icons.folder),
                          trailing: _viewType == describeEnum(viewType.Music)
                              ? Icon(
                                  Icons.play_arrow,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Text((_shownFiles[index] as Directory)
                                  .listSync()
                                  .length
                                  .toString()),
                          onTap: () {
                            _viewType == describeEnum(viewType.Music)
                                ? Player.play(_shownFiles[index].path)
                                :
                                //   _shownFiles =
                                //       (_shownFiles[index] as Directory)
                                //           .listSync();
                                //   _viewType = describeEnum(viewType.Music)
                                // ;
                                null;
                          },
                        ));
                  },
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: chooseType,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            label: 'Music',
            icon: Icon(Icons.audiotrack),
          ),
          BottomNavigationBarItem(
            label: 'Folders',
            icon: Icon(Icons.folder),
          ),
        ],
      ),
    );
  }
}
