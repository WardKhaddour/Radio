import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../models/channel.dart';
import '../providers/channels_provider.dart';
import '../widgets/channels_view.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textFiedFocusNode = FocusNode();
  final _textFieldController = TextEditingController();
  bool _isSearching = false;
  List<Channel> _searchResult = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Form(
                  child: TextFormField(
                    focusNode: _textFiedFocusNode,
                    controller: _textFieldController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Input Channel Name',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      icon: IconButton(
                        icon: Hero(
                          tag: 'search-icon',
                          child: Icon(Icons.search),
                        ),
                        onPressed: () {
                        }
                      ),
                      focusColor: Colors.teal,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isSearching = true;
                      });
                      // _textFieldController.text = value;
                      setState(() {
                        _searchResult = Provider.of<ChannelsProvider>(context,
                                listen: false)
                            .searchChannel(value);
                        _isSearching = false;
                      });
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        _isSearching = true;
                        _searchResult = Provider.of<ChannelsProvider>(context,
                                listen: false)
                            .searchChannel(value);
                        _isSearching = false;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isSearching
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.green,
              ),
            )
          : _searchResult.isEmpty
              ? Center(
                  child: Text(
                    'No Items Found',
                    style: TextStyle(color: Colors.teal, fontSize: 24),
                  ),
                )
              : ChannelsGridView(channels: _searchResult),
    );
  }
}
