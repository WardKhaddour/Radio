import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicProvider with ChangeNotifier {
  List<File> _files = [];
  // List<File> get files {
  //   return [..._files];
  // }
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

  Future<List<File>> get files async {
    final storagePer = await Permission.storage.request();
    final exStoragePer = await Permission.manageExternalStorage.request();

    if (storagePer.isDenied) {
      return [];
    }
    if (exStoragePer.isDenied) {
      return [];
    }

    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    String root = storageInfo[0].rootDir;
    FileManager fm = FileManager(root: Directory(root));
    _files = await fm.filesTree(
      excludedPaths: ["/storage/0"],
      extensions: ["mp3", 'wav', 'aac'],
    );
    return [..._files];
  }
}