import 'dart:io';

class FilesGetter {
  List<Directory> _directories = [];
  List<Directory> get directories {
    return [..._directories];
  }

  List<File> filterFiles(Directory dir) {
    List<File> temp = [];
    List<Directory> directories = [];
    dir.listSync().forEach((element) {
      if (element.statSync().type == FileSystemEntityType.directory) {
        final res = filterFiles(Directory(element.path));
        temp.addAll(res);
        if (filterSongs(res).isNotEmpty) {
          directories.add(element);
        }
      } else if (element.statSync().type == FileSystemEntityType.file) {
        temp.add(element);
      }
    });
    _directories.addAll(directories);
    return temp;
  }

  List<File> filterSongs(List<File> files) {
    List<String> extensions = ['mp3', 'wav', 'aac', 'm4a'];
    List<File> temp = [];
    files.forEach((element) {
      if (extensions.contains(element.path.split('.').last)) {
        temp.add(element);
      }
    });
    return temp;
  }

  List<File> getFilesFromDirectory(Directory dir) {
    List<File> temp = [];
    dir.listSync().forEach((element) {
      if (element.statSync().type == FileSystemEntityType.file) {
        temp.add(element);
      }
    });
    temp = filterSongs(temp);
    return temp;
  }
}
