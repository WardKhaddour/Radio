import 'package:flutter/material.dart';
import '../models/channel.dart';
import '../services/channels_getter.dart';

class ChannelsProvider with ChangeNotifier {
  List<Channel> _channels = [];
  bool onlyFav = false;
  //Methods
  Future<void> updateChannels(String countryName) async {
    _channels = await ChannelsGetter().getChannels(countryName);

    notifyListeners();
  }

  List<Channel> get channels {
    return _channels.where((element) => !element.isDeleted).toList();
  }

  List<Channel> get favoriteChannels {
    return _channels
        .where((element) => element.isFavourite && !element.isDeleted)
        .toList();
  }

  List<Channel> get deletedChannels {
    return _channels.where((element) => element.isDeleted).toList();
  }

  List<Channel> searchResult(String channelName) {
    // final temp = <Channel>[];
    if (channelName.isEmpty) {
      return [];
    }
    return _channels
        .where((element) =>
            (element.name.toLowerCase().contains(channelName.toLowerCase())))
        .toList();
  }

  void showFav() {
    onlyFav = true;
    notifyListeners();
  }

  void showAll() {
    onlyFav = false;
    notifyListeners();
  }

  void toggleFavorite(String channelId) {
    _channels
        .firstWhere((channel) => channel.id == channelId)
        .toggleFavourites();
    notifyListeners();
  }

  void deleteChannel(String channelId) {
    _channels.firstWhere((channel) => channel.id == channelId).deleteChannel();

    notifyListeners();
  }

  void restoreChannel(String channelId) {
    _channels.firstWhere((channel) => channel.id == channelId).restoreChannel();

    notifyListeners();
  }
}
