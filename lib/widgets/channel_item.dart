import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/providers/player_provider.dart';
import '../screens/radio_channels_screen.dart';
import '../services/player.dart';
import '../models/channel.dart';
import './scrolling_text.dart';
import './channel_info_dialog.dart';
import './channel_image.dart';
import './delete_icon.dart';
import './favorite_icon.dart';

class ChannelItem extends StatefulWidget {
  final Channel channel;
  final String viewType;
  ChannelItem({
    @required this.channel,
    @required this.viewType,
  });

  @override
  _ChannelItemState createState() => _ChannelItemState();
}

class _ChannelItemState extends State<ChannelItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Provider.of<PlayerProvider>(context, listen: false)
            .setCurrentChannel(widget.channel.name);
        await Player.playFromUrl(widget.channel.url);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) => ChannelInfoDialog(channel: widget.channel),
        );
      },
      child: widget.viewType == describeEnum(view.Grid)
          ? GridTile(
              child: ChannelImage(widget: widget),
              footer: GridTileBar(
                backgroundColor: Colors.teal,
                title: ScrollingText(
                  text: widget.channel.name,
                  textStyle: TextStyle(fontSize: 15),
                ),
                leading: FavoriteIcon(context, widget),
                trailing: DeleteIcon(context, widget),
              ),
            )
          : ListTile(
              leading: ChannelImage(
                widget: widget,
              ),
              title: Text(
                widget.channel.name,
                style: TextStyle(fontSize: 15),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FavoriteIcon(context, widget),
                  DeleteIcon(context, widget),
                ],
              ),
            ),
    );
  }
}
