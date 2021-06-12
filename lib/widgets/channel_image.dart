import 'package:flutter/material.dart';
import './channel_item.dart';

import '../constatnts.dart';

class ChannelImage extends StatelessWidget {
  ChannelImage({this.widget});
  final ChannelItem widget;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'channel-grid-logo',
      child: FadeInImage(
        placeholder: AssetImage(radioImage),
        image: NetworkImage(
          widget.channel.imageUrl,
        ),
      ),
    );
  }
}
