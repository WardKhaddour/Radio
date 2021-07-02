import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/folders_view.dart';
import '../widgets/music_view.dart';
import '../widgets/appbar_flexible_space.dart';
import '../widgets/background.dart';
import '../services/player.dart';
import '../providers/music_provider.dart';

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
  bool _playing = false;
  // bool _activeSearch = false;
  String _viewType = describeEnum(viewType.Music);
  String _searchName = '';
  int _index = 0;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      await Provider.of<MusicProvider>(context, listen: false).getFiles();
    });
    super.initState();
  }

  Future<void> chooseType(int index) async {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Provider.of<MusicProvider>(context, listen: false)
                    .filesInDir
                    .isEmpty &&
                _viewType == describeEnum(viewType.Folders)) {
              chooseType(0);
            } else if (Provider.of<MusicProvider>(context, listen: false)
                    .filesInDir
                    .isNotEmpty &&
                _viewType == describeEnum(viewType.Folders)) {
              Provider.of<MusicProvider>(context, listen: false).closeFolder();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        flexibleSpace: AppBarFlexibleSpace(),
        title: Provider.of<MusicProvider>(context).activeSearch
            ? TextField(
                autofocus: true,
                onChanged: (value) {
                  _searchName = value;
                  setState(() {
                    Provider.of<MusicProvider>(context, listen: false)
                        .searchFile(_searchName);
                  });
                },
              )
            : Text('My Music'),
        actions: [
          !Provider.of<MusicProvider>(context).activeSearch
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
              icon: Icon(Provider.of<MusicProvider>(context).activeSearch
                  ? Icons.close
                  : Icons.search),
              onPressed: () {
                Provider.of<MusicProvider>(context, listen: false)
                    .toggleSearch();
              }),
        ],
      ),
      // drawer: AppDrawer(),

      body: BackGround(
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Provider.of<MusicProvider>(context, listen: false).getFiles();
          },
          child: _viewType == describeEnum(viewType.Music)
              ? MusicView()
              : FoldersView(),
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
