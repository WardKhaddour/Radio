import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/channel.dart';
import '../providers/channels_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/radio_channels_bottom_navigator_bar.dart';
import '../widgets/channels_view.dart';
import '../widgets/countries_dialog.dart';
import '../providers/countries_provider.dart';

enum view {
  List,
  Grid,
}

class RadioChannelsScreen extends StatefulWidget {
  static const routeName = '/radio-channels';

  @override
  _RadioChannelsScreenState createState() => _RadioChannelsScreenState();
}

class _RadioChannelsScreenState extends State<RadioChannelsScreen> {
  String _viewType = describeEnum(view.Grid);
  String _currentCountry = 'Syrian Arab Republic';
  bool _isLoading = true;
  bool _activeSearch = false;
  List<Channel> _channels = [];
  List<Channel> _searchResult = [];
  String _searchName = '';
  SharedPreferences _pref;
  TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      _pref = await SharedPreferences.getInstance();

      setState(() {
        _isLoading = true;
      });
      setState(() {
        _currentCountry = _pref.containsKey('country')
            ? _pref.getString('country')
            : 'Syrian Arab Republic';
      });
      print('country name $_currentCountry');
      await Provider.of<ChannelsProvider>(context, listen: false)
          .updateChannels(_currentCountry);
      await Provider.of<CountriesProvider>(context, listen: false)
          .updateCountries();
      _channels =
          Provider.of<ChannelsProvider>(context, listen: false).channels;

      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Future.delayed(Duration(seconds: 0)).then((value) async {
    //   print('current country $_currentCountry');
    //   print('args ${ModalRoute.of(context).settings.arguments}');
    //   if (_currentCountry != ModalRoute.of(context).settings.arguments &&
    //       ModalRoute.of(context).settings.arguments != null) {
    //     final pref = await SharedPreferences.getInstance();
    //     _currentCountry = pref.containsKey('country')
    //         ? pref.getString('country')
    //         : 'Syrian Arab Republic';
    //     setState(() {
    //       _isLoading = true;
    //     });
    //     await Provider.of<ChannelsProvider>(context, listen: false)
    //         .updateChannels(_currentCountry);
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   } else {
    //     return;
    //   }
    // });

    _channels = Provider.of<ChannelsProvider>(context, listen: false).channels;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChannelsProvider>(context);
    setState(() {
      _currentCountry = _pref.containsKey('country')
          ? _pref.getString('country')
          : 'Syrian Arab Republic';
    });
    if (_searchResult.isNotEmpty || _activeSearch)
      _channels = _searchResult;
    else
      _channels = prov.onlyFav ? prov.favoriteChannels : prov.channels;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
              colors: [
                Colors.teal.shade100,
                Colors.teal.shade200,
                Colors.teal.shade300,
                Colors.teal.shade400,
                Colors.teal.shade500,
                Colors.teal.shade600,
                Colors.teal.shade700,
                // Colors.teal.shade800,
                // Colors.teal.shade900,
              ],
            ),
          ),
        ),
        title: _activeSearch
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  onChanged: (value) {
                    _searchName = value;
                    setState(() {
                      _searchResult = prov.searchResult(_searchName);
                    });
                  },
                  textInputAction: TextInputAction.search,
                  style: TextStyle(color: Theme.of(context).accentColor),
                  decoration: InputDecoration(
                    hintText: 'Input Channel Name',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            : Text('Radio Channels'),
        actions: [
          if (!_activeSearch)
            IconButton(
                icon: Icon(
                  isGridView() ? Icons.grid_view : Icons.view_list,
                ),
                onPressed: () {
                  setState(() {
                    toggleViewType();
                  });
                }),
          if (!_activeSearch)
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: TextButton(
                      child: Text('Search Channel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _activeSearch = true;
                          // _searchName='';
                        });
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton(
                      child: Text('Change Country'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => CountriesDialog(),
                        );
                      },
                    ),
                  ),
                ];
              },
            ),
          if (_activeSearch)
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _activeSearch = false;
                    // _searchName='';
                  });
                }),
        ],
      ),
      drawer: _activeSearch ? SizedBox() : AppDrawer(),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          await Provider.of<ChannelsProvider>(context, listen: false)
              .updateChannels(_currentCountry);
        },
        child: Scrollbar(
            child: _isLoading
                ? SpinKitDoubleBounce(color: Theme.of(context).primaryColor)
                : isGridView()
                    ? ChannelsGridView(channels: _channels)
                    : ChannelsListView(channels: _channels)),
      ),
      bottomNavigationBar: RadioChannelsBottomNavigatorBar(),
    );
  }
}
