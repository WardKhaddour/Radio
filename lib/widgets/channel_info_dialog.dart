import 'package:flutter/material.dart';
import '../constatnts.dart';
import '../models/channel.dart';

class ChannelInfoDialog extends StatelessWidget {
  ChannelInfoDialog({@required this.channel});

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.7),
      content: GridTile(
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
  }
}
