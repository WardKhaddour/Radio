import 'package:flutter/material.dart';
import '../constatnts.dart';
import '../models/channel.dart';

class ChannelInfoDialog extends StatelessWidget {
  ChannelInfoDialog({@required this.channel});

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: double.minPositive,
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.7),
      content: Column(
        children: [
          Hero(
            tag: 'channel-logo',
            child: Container(
              width: 150,
              height: 150,
              child: FadeInImage(
                placeholder: AssetImage(radioImage),
                image: NetworkImage(
                  channel.imageUrl,
                ),
              ),
            ),
          ),
          Card(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                channel.name,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
