import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/player_provider.dart';
import '../models/channel.dart';
import '../providers/channels_provider.dart';
import '../providers/countries_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/radio_channels_bottom_navigator_bar.dart';
import '../widgets/channels_view.dart';

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
  List<String> _countries = [];
  List<Channel> _channels = [];
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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      setState(() {
        _isLoading = true;
      });
      final pref = await SharedPreferences.getInstance();
      setState(() {
        _currentCountry = pref.containsKey('country')
            ? pref.getString('country')
            : 'Syrian Arab Republic';
      });
      await Provider.of<CountriesProvider>(context, listen: false)
          .updateCountries();
      await Provider.of<ChannelsProvider>(context, listen: false)
          .updateChannels(_currentCountry);

      _countries =
          Provider.of<CountriesProvider>(context, listen: false).countries;
      _channels =
          Provider.of<ChannelsProvider>(context, listen: false).channels;

      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
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
              icon: Icon(
                isGridView() ? Icons.grid_view : Icons.view_list,
              ),
              onPressed: () {
                setState(() {
                  toggleViewType();
                });
              }),
          IconButton(
              icon: Hero(
                tag: 'search-icon',
                child: Icon(Icons.search),
              ),
              onPressed: () {
                // Navigator.of(context).pushNamed(SearchScreen.routeName);
                //  showSearch(context: context, delegate:SearchDelegate().showResults(context));
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
              setState(() {
                _currentCountry = value;
              });
              await Provider.of<ChannelsProvider>(context, listen: false)
                  .updateChannels(_currentCountry);
              setState(() {
                _isLoading = false;
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? SpinKitDoubleBounce(color: Colors.teal)
          : isGridView()
              ? ChannelsGridView(channels: _channels)
              : ChannelsListView(channels: _channels),
      bottomNavigationBar: RadioChannelsBottomNavigatorBar(),
    );
  }
}
