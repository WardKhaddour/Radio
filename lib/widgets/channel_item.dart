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
        await Player.play(widget.channel.url);
      },
      onLongPress: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) => ChannelInfoDialog(channel: widget.channel),
        );
      },
      child: widget.viewType == describeEnum(view.Grid)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: ChannelImage(
                    widget: widget,
                    width: 75,
                    height: 75,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GridTileBar(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    title: ScrollingText(
                      text: widget.channel.name,
                      textStyle: TextStyle(fontSize: 15),
                    ),
                    leading: FavoriteIcon(
                      context: context,
                      widget: widget,
                      iconColor: Theme.of(context).accentColor,
                    ),
                    trailing: DeleteIcon(
                      context: context,
                      widget: widget,
                      iconColor: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            )
          // ? GridTile(
          //     child: ChannelImage(widget: widget),
          //     footer: GridTileBar(
          //       backgroundColor:
          //           Theme.of(context).primaryColor.withOpacity(0.5),

          //       title: ScrollingText(
          //         text: widget.channel.name,
          //         textStyle: TextStyle(fontSize: 15),
          //       ),
          //       leading: FavoriteIcon(
          //         context: context,
          //         widget: widget,
          //         iconColor: Colors.white,
          //       ),
          //       trailing: DeleteIcon(
          //         context: context,
          //         widget: widget,
          //         iconColor: Colors.white,
          //       ),
          //     ),
          //   )
          : ListTile(
              leading: ChannelImage(
                widget: widget,
                width: 50,
                height: 50,
              ),
              title: Text(
                widget.channel.name,
                style: TextStyle(fontSize: 15),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FavoriteIcon(
                    context: context,
                    widget: widget,
                    iconColor: Colors.grey,
                  ),
                  DeleteIcon(
                    context: context,
                    widget: widget,
                    iconColor: Colors.grey,
                  ),
                ],
              ),
            ),
    );
  }
}
