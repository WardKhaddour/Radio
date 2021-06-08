import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Channel {
  final String name;
  final String url;
  final String imageUrl;
  final String id;
  bool isFavourite = false;
  bool isDeleted = false;

  Channel({
    @required this.name,
    @required this.url,
    @required this.imageUrl,
    @required this.id,
    this.isDeleted,
    this.isFavourite,
  });
  void toggleFavourites() async {
    isFavourite = !isFavourite;
    final pref = await SharedPreferences.getInstance();
    pref.setBool(id + 'favorite', isFavourite);
  }

  void deleteChannel() async {
    isDeleted = true;
    final pref = await SharedPreferences.getInstance();
    pref.setBool(id + 'deleted', isDeleted);
  }
}
