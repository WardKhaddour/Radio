import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/player.dart';
import '../providers/music_provider.dart';
import '../widgets/background.dart';

class FoldersView extends StatefulWidget {
  @override
  _FoldersViewState createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> {
  List<Directory> _directories = [];
  List<File> _music = [];
  @override
  void initState() {
    _directories =
        Provider.of<MusicProvider>(context, listen: false).directories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MusicProvider>(context);
    _directories = prov.directories;
    _music = prov.filesInDir;
    return BackGround(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: _music.isEmpty ? _directories.length : _music.length,
          itemBuilder: (BuildContext context, index) {
            final title = _music.isEmpty
                ? _directories[index].path.split('/').last
                : _music[index].path.split('/').last;
            final icon = _music.isEmpty ? Icons.folder : Icons.audiotrack;
            final trailing = _music.isEmpty
                ? _directories[index].listSync().length.toString()
                : " ";
            final onTap = () {
              _music.isEmpty
                  ? Provider.of<MusicProvider>(context, listen: false)
                      .getFilesFromDirectory(_directories[index])
                  : Player.playMusic(_music[index].path);
            };
            final color = _music.isEmpty ? Colors.grey.shade300 : Colors.white;
            return Card(
              color: color,
              child: ListTile(
                title: Text(title),
                leading: Icon(icon),
                trailing: Text(trailing),
                onTap: onTap,
              ),
            );
          },
        ),
      ),
    );
  }
}
