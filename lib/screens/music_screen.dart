import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/app_drawer.dart';

class MusicScreen extends StatefulWidget {
  static const routeName = '/music-screen';

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool _showSearchBar = false;
  List<File> _files;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      _files = await Provider.of<MusicProvider>(context, listen: false).files;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _showSearchBar = true;
                });
              })
        ],
      ),
      drawer: AppDrawer(),
      body: _files == null
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
                    Provider.of<PlayerProvider>(context, listen: false)
                        .setPath(_files[index].path);
                  },
                ));
              },
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
