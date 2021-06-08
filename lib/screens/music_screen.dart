import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import '../providers/player_provider.dart';
import '../widgets/app_drawer.dart';

class MusicScreen extends StatefulWidget {
  static const routeName = '/music-screen';

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  List<File> files;
  void getFiles() async {
    final storagePer = await Permission.storage.request();
    final exStoragePer = await Permission.manageExternalStorage.request();
    if (storagePer.isDenied) {
      return;
    }
    if (exStoragePer.isDenied) {
      return;
    }
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    String root = storageInfo[0].rootDir;
    FileManager fm = FileManager(root: Directory(root));

    files = await fm.filesTree(
      excludedPaths: ["/storage/0"],
      extensions: ["mp3", 'wav', 'aac'],
    );
    print(files);
    setState(() {});
  }

  @override
  void initState() {
    getFiles();
    super.initState();
  }

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
      drawer: AppDrawer(),
      body: files == null
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
              itemCount: files?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  title: Text(files[index].path.split('/').last),
                  leading: Icon(Icons.audiotrack),
                  trailing: Icon(
                    Icons.play_arrow,
                    color: Colors.teal,
                  ),
                  onTap: () {
                    Provider.of<PlayerProvider>(context, listen: false)
                        .setPath(files[index].path);
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
