import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channels_provider.dart';
import './channel_item.dart';

class FavoriteIcon extends StatelessWidget {
  FavoriteIcon(this.context, this.widget);
  final BuildContext context;

  final ChannelItem widget;
  void favoriteIconPressed() {
    Provider.of<ChannelsProvider>(context, listen: false)
        .toggleFavorite(widget.channel.id);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        !widget.channel.isFavourite
            ? 'Removed From Favorites'
            : 'Added To Favorites',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.grey,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: widget.channel.isFavourite ? Colors.redAccent : Colors.grey,
      ),
      onPressed: favoriteIconPressed,
    );
  }
}
