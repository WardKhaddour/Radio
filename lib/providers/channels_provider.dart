import 'package:flutter/material.dart';
import '../models/channel.dart';
import '../services/channels_getter.dart';

class ChannelsProvider with ChangeNotifier {
  List<Channel> _channels = [];
  List<Channel> _searchResut = [];
  List<Channel> get channels {
    List<Channel> temp = [];
    _channels.forEach((element) {
      if (!element.isDeleted) {
        temp.add(element);
      }
    });
    return temp;
  }

  List<Channel> get favoritesChannels {
    List<Channel> temp = [];
    _channels.forEach((element) {
      if (element.isFavourite && !element.isDeleted) temp.add(element);
    });
    return temp;
  }

  Future<void> updateChannels(String countryName) async {
    _channels = await ChannelsGetter().getChannels(countryName);

    notifyListeners();
  }

  List<Channel> searchChannel(String channelName) {
    _channels.forEach(
      (element) {
        if (element.name.toLowerCase().contains(channelName.toLowerCase())) {
          _searchResut.add(element);
        }
      },
    );
    notifyListeners();
    return [..._searchResut];
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
}
