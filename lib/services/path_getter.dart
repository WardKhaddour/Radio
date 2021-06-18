import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathGetter {
  Future<Directory> getExternalSdCardPath() async {
    List<Directory> extDirectories = await getExternalStorageDirectories();

    List<String> dirs = extDirectories[1].toString().split('/');
    print('dirs $dirs');
    String rebuiltPath = '/' + dirs[1] + '/' + dirs[2] + '/';

    print("rebuilt path: " + rebuiltPath);
    return Directory(rebuiltPath);
  }

  Future<Directory> getInternalStoragePath() async {
    List<Directory> extDirectories = await getExternalStorageDirectories();

    List<String> dirs = extDirectories[0].toString().split('/');
    print('dirs $dirs');
    String rebuiltPath = '/' + dirs[1] + '/' + dirs[2] + '/0' + '/';

    print("rebuilt path: " + rebuiltPath);
    return Directory(rebuiltPath);
  }
}
