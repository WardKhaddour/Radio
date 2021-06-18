import 'dart:io';

class FilesGetter {
  List<Directory> directory = [];

  List<File> filterFiles(Directory dir) {
    List<File> temp = [];
    dir.listSync().forEach((element) {
      if (element.statSync().type == FileSystemEntityType.directory) {
        final res = filterFiles(Directory(element.path));
        temp.addAll(res);
        if (filterSongs(res).isNotEmpty) {
          directory.add(element);
        }
      } else if (element.statSync().type == FileSystemEntityType.file) {
        temp.add(element);
      }
    });
    print('directory ${directory.toString()}');
    return temp;
  }

  List<File> filterSongs(List<File> files) {
    List<String> extensions = ["mp3", 'wav', 'aac'];
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
    print('temp ${temp.toString()}');
    return temp;
  }
}
