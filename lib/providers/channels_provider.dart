import 'package:flutter/material.dart';
import '../models/channel.dart';
import '../services/channels_getter.dart';

class ChannelsProvider with ChangeNotifier {
  List<Channel> _channels = [];
  bool onlyFav = false;
  bool gettingChannels = false;
  Future<void> updateChannels(String countryName) async {
    gettingChannels = true;
    _channels = await ChannelsGetter().getChannels(countryName);
    gettingChannels = false;
    notifyListeners();
  }

  List<Channel> get channels =>
      _channels.where((element) => !element.isDeleted).toList();

  List<Channel> get favoriteChannels => _channels
      .where((element) => element.isFavourite && !element.isDeleted)
      .toList();

  List<Channel> get deletedChannels =>
      _channels.where((element) => element.isDeleted).toList();

  List<Channel> searchResult(String channelName) {
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

  void restoreAllChannels() {
    _channels.forEach((element) {
      if (element.isDeleted) restoreChannel(element.id);
    });
    notifyListeners();
  }

  void restoreChannel(String channelId) {
    _channels.firstWhere((channel) => channel.id == channelId).restoreChannel();
    notifyListeners();
  }
}
