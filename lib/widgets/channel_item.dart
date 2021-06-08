import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/providers/channels_provider.dart';
import '../models/channel.dart';
import '../constatnts.dart';
import '../providers/player_provider.dart';
import './scrolling_text.dart';

class ChannelGridViewItem extends StatelessWidget {
  final Channel channel;
  ChannelGridViewItem({
    @required this.channel,
  });
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PlayerProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        prov.setURL(channel.url);
        prov.setCurrentChannel(channel.name);
        prov.isPlaying() ? prov.pause() : prov.play();
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) => GridTile(
            child: Hero(
              tag: 'channel-grid-logo',
              child: FadeInImage(
                placeholder: AssetImage(radioImage),
                image: NetworkImage(
                  channel.imageUrl,
                ),
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.teal,
              title: Center(
                child: Text(
                  channel.name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        );
      },
      child: GridTile(
        child: Hero(
          tag: 'channel-grid-logo',
          child: FadeInImage(
            placeholder: AssetImage(radioImage),
            image: NetworkImage(
              channel.imageUrl,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.teal,
          title: ScrollingText(
            text: channel.name,
            textStyle: TextStyle(fontSize: 15),
          ),
          leading: IconButton(
              icon: Icon(Icons.favorite,
                  color: channel.isFavourite ? Colors.red : Colors.white),
              onPressed: () {
                Provider.of<ChannelsProvider>(context, listen: false)
                    .toggleFavorite(channel.id);
              }),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<ChannelsProvider>(context, listen: false)
                  .deleteChannel(channel.id);
            },
          ),
        ),
      ),
    );
  }
}

class ChannelListViewItem extends StatelessWidget {
  final Channel channel;
  ChannelListViewItem({
    @required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PlayerProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        prov.setURL(channel.url);
        prov.setCurrentChannel(channel.name);
        prov.isPlaying() ? prov.pause() : prov.play();
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) => GridTile(
            child: Hero(
              tag: 'channel-tile-logo',
              child: FadeInImage(
                placeholder: AssetImage(radioImage),
                image: NetworkImage(
                  channel.imageUrl,
                ),
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.teal,
              title: Center(
                child: Text(
                  channel.name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        );
      },
      child: ListTile(
        leading: Hero(
          tag: 'channel-tile-logo',
          child: FadeInImage(
            placeholder: AssetImage(radioImage),
            image: NetworkImage(channel.imageUrl),
          ),
        ),
        title: Text(
          channel.name,
          style: TextStyle(fontSize: 15),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: channel.isFavourite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                Provider.of<ChannelsProvider>(context, listen: false)
                    .toggleFavorite(channel.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<ChannelsProvider>(context, listen: false)
                    .deleteChannel(channel.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
