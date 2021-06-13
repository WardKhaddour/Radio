import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channels_provider.dart';
import './channel_item.dart';

class FavoriteIcon extends StatelessWidget {
  final BuildContext context;
  final ChannelItem widget;
  final Color iconColor;
  FavoriteIcon(
      {@required this.context,
      @required this.widget,
      this.iconColor = Colors.white});
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
        color: widget.channel.isFavourite ? Colors.redAccent : iconColor,
      ),
      onPressed: favoriteIconPressed,
    );
  }
}
