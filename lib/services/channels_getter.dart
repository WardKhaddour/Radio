import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radio/models/channel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChannelsGetter {
  Future<List<Channel>> getChannels(String countryName) async {
    final String url =
        'https://fr1.api.radio-browser.info/json/stations/bycountry/$countryName';

    http.Response response = await http.get(Uri.parse(url));
    List<Channel> channels = [];
    var extractedData = jsonDecode(response.body);
    final pref = await SharedPreferences.getInstance();
    extractedData.forEach((channel) {
      channels.add(Channel(
        name: channel['name'],
        url: channel['url'],
        imageUrl: channel['favicon'],
        id: channel['changeuuid'],
        isDeleted: pref.getBool(channel['changeuuid'] + 'deleted'),
        isFavourite: pref.getBool(channel['changeuuid' + 'favorite']),
      ));
    });

    return channels;
  }
}
