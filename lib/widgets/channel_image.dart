import 'package:flutter/material.dart';
import './channel_item.dart';

import '../constatnts.dart';

class ChannelImage extends StatelessWidget {
  ChannelImage({this.widget, this.height, this.width});
  final ChannelItem widget;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'channel-logo',
      child: Container(
        width: width,
        height: height,
        child: FadeInImage(
          placeholder: AssetImage(radioImage),
          image: NetworkImage(
            widget.channel.imageUrl,
          ),
        ),
      ),
    );
  }
}
