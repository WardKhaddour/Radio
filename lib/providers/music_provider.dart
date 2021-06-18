import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/path_getter.dart';
import '../services/files_getter.dart';

class MusicProvider with ChangeNotifier {
  List<File> _files = [];
  List<Directory> _directory = [];
  List<File> searchFile(String fileName) {
    List<File> temp = [];
    _files.forEach(
      (element) {
        if (element.path.split('/').last == fileName) {
          temp.add(element);
        }
      },
    );
    return temp;
  }

  List<File> get files {
    return [..._files];
  }

  List<Directory> get directory {
    return [..._directory];
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
      _directory = filesGetter.directory;
    }
    notifyListeners();
  }

  void getFilesFromDirectory(Directory dir) {
    final filesGetter = FilesGetter();

    _files = filesGetter.getFilesFromDirectory(dir);
    print("files ${_files.toString()}");
    notifyListeners();
  }
}
