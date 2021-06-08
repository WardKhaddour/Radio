import 'package:flutter/material.dart';
import '../widgets/channel_item.dart';
import '../models/channel.dart';

class ChannelsGridView extends StatelessWidget {
  ChannelsGridView({@required this.channels});

  final List<Channel> channels;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemCount: channels.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ChannelGridViewItem(
            channel: channels[index],
          );
        });
  }
}

class ChannelsListView extends StatelessWidget {
  ChannelsListView({@required this.channels});
  final List<Channel> channels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: channels.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ChannelListViewItem(
            channel: channels[index],
          );
        });
  }
}
