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
  String _currentCountry = 'Syrian Arab Republic';
  List<String> _searchResult = [];
  List<String> _countries = [];
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
    if (_searchResult.isNotEmpty) {
      _countries = _searchResult ?? [];
    } else {
      _countries = prov.countries ?? [];
    }
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
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
            // icon: IconButton(
            //   icon: Icon(Icons.clear),
            //   onPressed: () {
            //     setState(() {
            //       _searchName = '';

            //     });
            //   },
            // ),
          ),
        ),
      ),
      content: _isLoading
          ? SpinKitDualRing(color: Theme.of(context).primaryColor)
          : ListView.builder(
              itemCount: _countries.length,
              itemBuilder: (context, index) {
                int searchNameIndex =
                    _countries[index].indexOf(_searchName) == -1
                        ? 0
                        : _countries[index]
                            .toLowerCase()
                            .indexOf(_searchName.toLowerCase());

                return _countries.isNotEmpty && _countries != null
                    ? TextButton(
                        child: !_countries[index]
                                .toLowerCase()
                                .contains(_searchName.toLowerCase())
                            ? Text(_countries[index])
                            : RichText(
                                text: TextSpan(
                                    text: _countries[index]
                                        .substring(0, searchNameIndex),
                                    style: TextStyle(color: Colors.teal),
                                    children: [
                                      TextSpan(
                                        text: _searchName,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: _countries[index].substring(
                                            searchNameIndex +
                                                _searchName.length,
                                            _countries[index].length),
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                    ]),
                              ),
                        onPressed: () async {
                          _currentCountry = _countries[index];
                          final pref = await SharedPreferences.getInstance();
                          pref.setString('country', _countries[index]);

                          await Provider.of<ChannelsProvider>(context,
                                  listen: false)
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
