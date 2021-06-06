import 'package:flutter/material.dart';
import '../widgets/radio_drawer.dart';

class MusicScreen extends StatelessWidget {
  static const routeName = '/music-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Music'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //TODO:find music
              })
        ],
      ),
      drawer: RadioDrawer(),
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
