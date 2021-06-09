import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channels_provider.dart';
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
                  color: channel.isFavourite ? Colors.redAccent : Colors.white),
              onPressed: () {
                Provider.of<ChannelsProvider>(context, listen: false)
                    .toggleFavorite(channel.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    channel.isFavourite
                        ? 'Removed From Favorites'
                        : 'Added To Favorites',
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.grey,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ));
              }),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Channel?'),
                  titlePadding: EdgeInsets.all(16),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Provider.of<ChannelsProvider>(context, listen: false)
                            .deleteChannel(channel.id);
                      },
                      child: Text(
                        'YES',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'NO',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
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
                color: channel.isFavourite ? Colors.redAccent : Colors.white,
              ),
              onPressed: () {
                Provider.of<ChannelsProvider>(context, listen: false)
                    .toggleFavorite(channel.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    channel.isFavourite
                        ? 'Removed From Favorites'
                        : 'Added To Favorites',
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.grey,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete Channel?'),
                    titlePadding: EdgeInsets.all(16),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Provider.of<ChannelsProvider>(context, listen: false)
                              .deleteChannel(channel.id);
                        },
                        child: Text(
                          'YES',
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'NO',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
