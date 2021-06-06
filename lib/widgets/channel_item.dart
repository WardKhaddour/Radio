import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constatnts.dart';
import '../providers/player_provider.dart';
import './scrolling_text.dart';

class ChannelGridViewItem extends StatelessWidget {
  final String imageURL;
  final String channelName;
  final String url;
  ChannelGridViewItem(
      {@required this.imageURL,
      @required this.channelName,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PlayerProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        prov.setURL(url);
        prov.setCurrentChannel(channelName);
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
                  imageURL,
                ),
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.teal,
              title: Center(
                child: Text(
                  channelName,
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
              imageURL,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.teal,
          title: ScrollingText(
            text: channelName,
            textStyle: TextStyle(fontSize: 15),
          ),
          leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                //TODO: add to fav
              }),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              //TODO: remove channel
            },
          ),
        ),
      ),
    );
  }
}

class ChannelListViewItem extends StatelessWidget {
  final String imageURL;
  final String channelName;
  final String url;
  ChannelListViewItem(
      {@required this.imageURL,
      @required this.channelName,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PlayerProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        prov.setURL(url);
        prov.setCurrentChannel(channelName);
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
                  imageURL,
                ),
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.teal,
              title: Center(
                child: Text(
                  channelName,
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
            image: NetworkImage(imageURL),
          ),
        ),
        title: Text(
          channelName,
          style: TextStyle(fontSize: 15),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                //TODO: add to fav
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                //TODO: remove channel
              },
            ),
          ],
        ),
      ),
    );
  }
}
