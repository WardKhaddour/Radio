import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:radio/providers/channels_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/countries_provider.dart';

class CountriesDialog extends StatefulWidget {
  @override
  _CountriesDialogState createState() => _CountriesDialogState();
}

class _CountriesDialogState extends State<CountriesDialog> {
  String initCap(String string) {
    String s = "";
    s += string[0].toUpperCase();
    for (int i = 1; i < string.length; ++i) {
      if (string[i - 1] == " ")
        s += string[i].toUpperCase();
      else
        s += string[i].toLowerCase();
    }
    return s;
  }

  String _currentCountry = 'Syrian Arab Republic';
  List<String> _searchResult = [];
  List<String> _countries = [];
  TextEditingController _controller = TextEditingController();
  String _searchName = '';
  bool _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      final prov = Provider.of<CountriesProvider>(context, listen: false);
      setState(() {
        _isLoading = true;
      });
      if (prov.countries.isEmpty) {
        await prov.updateCountries();
      }
      _countries = prov.countries ?? [];
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<CountriesProvider>(context);
    List<int> searchNamesIndexes = [];

    if (_searchResult.isNotEmpty) {
      _countries = _searchResult ?? [];
    } else {
      _countries = prov.countries ?? [];
    }
    for (int i = 0; i < _countries.length; ++i) {
      searchNamesIndexes
          .add(_countries[i].toLowerCase().indexOf(_searchName.toLowerCase()));
    }
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                autofocus: true,
                onChanged: (value) {
                  _searchName = value;

                  setState(() {
                    _searchResult = prov.searchCountry(_searchName) ?? [];
                  });
                },
                textInputAction: TextInputAction.search,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  hintText: 'Input Country Name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _searchName = '';
                    _controller.clear();
                  });
                }),
          )
        ],
      ),
      content: _isLoading
          ? SpinKitDualRing(color: Theme.of(context).primaryColor)
          : ListView.builder(
              itemCount: _countries.length,
              itemBuilder: (context, index) {
                return _countries.isNotEmpty && _countries != null
                    ? TextButton(
                        child: searchNamesIndexes[index] == -1
                            ? Text(_countries[index])
                            : RichText(
                                text: TextSpan(
                                  text: _countries[index]
                                      .substring(0, searchNamesIndexes[index]),
                                  style: TextStyle(color: Colors.teal),
                                  children: [
                                    TextSpan(
                                      text: _countries[index].substring(
                                          searchNamesIndexes[index],
                                          searchNamesIndexes[index] +
                                              _searchName.length),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: _countries[index].substring(
                                          searchNamesIndexes[index] +
                                              _searchName.length,
                                          _countries[index].length),
                                      style: TextStyle(color: Colors.teal),
                                    ),
                                  ],
                                ),
                              ),
                        onPressed: () async {
                          _currentCountry = _countries[index];
                          final pref = await SharedPreferences.getInstance();
                          pref.setString('country', _countries[index]);

                          Provider.of<ChannelsProvider>(context, listen: false)
                              .updateChannels(_currentCountry);
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop(_currentCountry);
                        },
                      )
                    : Text('');
              },
            ),
    );
  }
}
