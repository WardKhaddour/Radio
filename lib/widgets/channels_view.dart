import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channels_provider.dart';
import '../widgets/channel_item.dart';
import '../models/channel.dart';

class ChannelsGridView extends StatefulWidget {
  ChannelsGridView({@required this.channels});

  final List<Channel> channels;

  @override
  _ChannelsGridViewState createState() => _ChannelsGridViewState();
}

class _ChannelsGridViewState extends State<ChannelsGridView> {
  bool _showFavoritesOnly = false;

  void toggleShowFav() {
    setState(() {
      _showFavoritesOnly = !_showFavoritesOnly;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemCount: widget.channels.length,
        itemBuilder: (BuildContext ctx, int index) {
          return !_showFavoritesOnly
              ? ChannelGridViewItem(
                  channel: widget.channels[index],
                )
              : ChannelGridViewItem(
                  channel: Provider.of<ChannelsProvider>(context, listen: false)
                      .favoritesChannels[index],
                );
        });
  }
}

class ChannelsListView extends StatefulWidget {
  ChannelsListView({@required this.channels});
  final List<Channel> channels;

  @override
  _ChannelsListViewState createState() => _ChannelsListViewState();
}

class _ChannelsListViewState extends State<ChannelsListView> {
  bool _showFavoritesOnly = false;

  void toggleShowFav() {
    setState(() {
      _showFavoritesOnly = !_showFavoritesOnly;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.channels.length,
        itemBuilder: (BuildContext ctx, int index) {
          return !_showFavoritesOnly
              ? ChannelListViewItem(
                  channel: widget.channels[index],
                )
              : ChannelListViewItem(
                  channel: Provider.of<ChannelsProvider>(context, listen: false)
                      .favoritesChannels[index],
                );
        });
  }
}
