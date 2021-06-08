import 'dart:io';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicGetter {
  Future<List<File>> getFiles() async {
    List<File> files;
    final storagePer = await Permission.storage.request();
    final exStoragePer = await Permission.manageExternalStorage.request();
    if (storagePer.isDenied) {
      return [];
    }
    if (exStoragePer.isDenied) {
      return [];
    }
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    String root = storageInfo[1].rootDir;
    FileManager fm = FileManager(root: Directory(root));

    files = await fm.filesTree(
      excludedPaths: ["/storage/1"],
      extensions: ["mp3", 'wav', 'aac'],
    );
    print(files);
    return files;
  }
}
