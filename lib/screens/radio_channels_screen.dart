import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/player_provider.dart';
import '../models/channel.dart';
import '../providers/channels_provider.dart';
import '../providers/countries_provider.dart';
import '../widgets/channel_item.dart';
import '../widgets/radio_drawer.dart';
import '../widgets/radio_channels_bottom_navigator_bar.dart';

enum view { List, Grid }

class RadioChannelesScreen extends StatefulWidget {
  static const routeName = '/radio-channels';

  @override
  _RadioChannelesScreenState createState() => _RadioChannelesScreenState();
}

class _RadioChannelesScreenState extends State<RadioChannelesScreen> {
  String _viewType = describeEnum(view.Grid);
  String _currentCountry = 'Syrian Arab Republic';
  bool _isLoading = true;
  bool _activeSearch = false;
  List<String> _countries = [];
  List<Channel> _channels = [];
  List<Channel> _searchResult = [];
  void toggleViewType() {
    _viewType == describeEnum(view.Grid)
        ? _viewType = describeEnum(view.List)
        : _viewType = describeEnum(view.Grid);
  }

  bool isGridView() {
    if (_viewType == describeEnum(view.Grid)) return true;
    return false;
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      setState(() {
        _isLoading = true;
      });
      final pref = await SharedPreferences.getInstance();
      _currentCountry = pref.containsKey('country')
          ? pref.getString('country')
          : 'Syrian Arab Republic';
      await Provider.of<CountriesProvider>(context, listen: false)
          .updateCountries();
      await Provider.of<ChannelsProvider>(context, listen: false)
          .updateChannels(_currentCountry);
      setState(() {
        _countries =
            Provider.of<CountriesProvider>(context, listen: false).countries;
        _channels =
            Provider.of<ChannelsProvider>(context, listen: false).channels;
      });
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: ScrollingText(
        //   text: Provider.of<PlayerProvider>(context).currentChannel ??
        //       'Choose Channel',
        // ),
        actions: [
          Provider.of<PlayerProvider>(context).isPlaying()
              ? IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () async {
                    await Provider.of<PlayerProvider>(context, listen: false)
                        .pause();
                  })
              : IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () async {
                    await Provider.of<PlayerProvider>(context, listen: false)
                        .play();
                  }),
          IconButton(
            onPressed: () {
              setState(() {
                _activeSearch = !_activeSearch;
              });
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    String name;
                    return Container(
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _searchResult = Provider.of<ChannelsProvider>(
                                        context,
                                        listen: false)
                                    .search(name);
                              },
                              child: Text('Search')),
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
              icon: Icon(
                isGridView() ? Icons.grid_view : Icons.view_list,
              ),
              onPressed: () {
                setState(() {
                  toggleViewType();
                });
              }),
          PopupMenuButton(
            icon: Icon(Icons.language),
            itemBuilder: (context) {
              return _countries
                  .map(
                    (country) => PopupMenuItem(
                      child: Text(country),
                      value: country,
                    ),
                  )
                  .toList();
            },
            onSelected: (value) async {
              final pref = await SharedPreferences.getInstance();
              pref.setString('country', value);
              setState(() {
                _isLoading = true;
              });
              _currentCountry = value;
              await Provider.of<ChannelsProvider>(context, listen: false)
                  .updateChannels(_currentCountry);
              setState(() {
                _isLoading = false;
              });
            },
          ),
        ],
      ),
      drawer: RadioDrawer(),
      body: _isLoading
          ? SpinKitDoubleBounce(color: Colors.teal)
          : isGridView()
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: _channels.length,
                  itemBuilder: (BuildContext ctx, int index) =>
                      ChannelGridViewItem(
                    channelName: _channels[index].name,
                    imageURL: _channels[index].imageUrl,
                    url: _channels[index].url,
                  ),
                )
              : ListView.builder(
                  itemCount: _channels.length,
                  itemBuilder: (BuildContext ctx, int index) =>
                      ChannelListViewItem(
                    channelName: _channels[index].name,
                    imageURL: _channels[index].imageUrl,
                    url: _channels[index].url,
                  ),
                ),
      bottomNavigationBar: RadioChannelsBottomNavigatorBar(),
    );
  }
}
