import 'dart:io';

import 'package:flutter/cupertino.dart';

class MusicProvider with ChangeNotifier {
  List<File> _files = [];
  List<File> get files {
    return [..._files];
  }

  List<File> searchFile(File file) {
    List<File> temp = [];
    _files.forEach(
      (element) {
        if (element == file) {
          temp.add(element);
        }
      },
    );
    return temp;
  }
}
