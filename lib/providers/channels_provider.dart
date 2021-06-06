import 'package:flutter/material.dart';
import '../models/channel.dart';
import '../services/channels_getter.dart';

class ChannelsProvider with ChangeNotifier {
  List<Channel> _channels = [];
  List<Channel> _searchResut = [];

  List<Channel> get channels {
    return [..._channels];
  }

  Future<void> updateChannels(String countryName) async {
    _channels = await ChannelsGetter().getChannels(countryName);

    notifyListeners();
  }

  List<Channel> search(String name) {
    _channels.forEach((element) {
      if (element.name.toLowerCase().contains(name.toLowerCase())) {
        _searchResut.add(element);
      }
    });
    notifyListeners();
    return [..._searchResut];
  }
}
