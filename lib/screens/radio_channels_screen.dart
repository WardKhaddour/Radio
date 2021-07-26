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
import '../widgets/appbar_flexible_space.dart';
import '../widgets/background.dart';
import '../providers/countries_provider.dart';

enum View {
  List,
  Grid,
}

class RadioChannelsScreen extends StatefulWidget {
  static const routeName = '/radio-channels';

  @override
  _RadioChannelsScreenState createState() => _RadioChannelsScreenState();
}

class _RadioChannelsScreenState extends State<RadioChannelsScreen> {
  String _viewType = describeEnum(View.Grid);
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

  Future<void> updateChannels() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<ChannelsProvider>(context, listen: false)
        .updateChannels(_currentCountry)
        .then((_) => _channels =
            Provider.of<ChannelsProvider>(context, listen: false).channels);

    setState(() {
      _isLoading = false;
    });
  }

  void toggleViewType() {
    _viewType == describeEnum(View.Grid)
        ? _viewType = describeEnum(View.List)
        : _viewType = describeEnum(View.Grid);
  }

  bool isGridView() {
    if (_viewType == describeEnum(View.Grid)) return true;
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
    _channels = Provider.of<ChannelsProvider>(context, listen: false).channels;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChannelsProvider>(context);
    setState(() {
      if (_pref == null) return;
      _currentCountry = _pref.getString('country') ?? 'Syrian Arab Republic';
    });
    if (_searchResult.isNotEmpty || _activeSearch)
      _channels = _searchResult;
    else
      _channels = prov.onlyFav ? prov.favoriteChannels : prov.channels;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarFlexibleSpace(),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  ),
                  PopupMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text('Change Country'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => CountriesDialog(),
                          ).then((value) async {
                            if (value.toString().toLowerCase() !=
                                _currentCountry.toLowerCase()) {
                              await updateChannels();
                            } else {
                              return;
                            }
                          });
                        },
                      ),
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
                    _searchName = '';
                    _searchResult = [];
                  });
                }),
        ],
      ),
      drawer: _activeSearch ? SizedBox() : AppDrawer(),
      body: BackGround(
        child: RefreshIndicator(
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
      ),
      bottomNavigationBar: RadioChannelsBottomNavigatorBar(),
    );
  }
}
