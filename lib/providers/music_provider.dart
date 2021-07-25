import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/path_getter.dart';
import '../services/files_getter.dart';

class MusicProvider with ChangeNotifier {
  List<File> _files = [];
  List<Directory> _directories = [];
  List<File> _filesInDir = [];
  List _searchResult = [];
  bool _activeSearch = false;

  bool get activeSearch => _activeSearch;

  List<Directory> get directories => [..._directories];

  List<File> get files => [..._files];

  List<File> get filesInDir => [..._filesInDir];

  List<File> get searchResult => [..._searchResult];

  void toggleSearch() {
    _activeSearch = !_activeSearch;
    notifyListeners();
  }

  void searchFolder(String folderName) {
    if (folderName.isEmpty) {
      return;
    }
    _searchResult = _directories
        .where((element) =>
            element.toString().toLowerCase().contains(folderName.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void searchFile(String fileName) {
    if (fileName.isEmpty) {
      return;
    }
    _searchResult = _files
        .where((element) =>
            element.toString().toLowerCase().contains(fileName.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> getFiles() async {
    final filesGetter = FilesGetter();

    final pathGetter = PathGetter();

    final storagePer = await Permission.storage.request();

    final exStoragePer = await Permission.manageExternalStorage.request();

    if (storagePer.isDenied) {
      return [];
    }
    if (exStoragePer.isDenied) {
      return [];
    }
    Directory sdCardDirectory = await pathGetter.getExternalSdCardPath();

    Directory internalStorageDirectory =
        await pathGetter.getInternalStoragePath();

    if (await Permission.storage.request().isGranted) {
      final sdCardFiles = filesGetter.filterFiles(sdCardDirectory);
      final internalStorageFiles =
          filesGetter.filterFiles(internalStorageDirectory);
      _files = filesGetter.filterSongs(sdCardFiles) +
          filesGetter.filterSongs(internalStorageFiles);
      _directories = filesGetter.directories;
    }
    notifyListeners();
  }

  void getFilesFromDirectory(Directory dir) {
    final filesGetter = FilesGetter();

    _filesInDir = filesGetter.getFilesFromDirectory(dir);
    notifyListeners();
  }

  void closeFolder() {
    _filesInDir = [];
    notifyListeners();
  }
}
