import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channels_provider.dart';
import './channel_item.dart';

class DeleteIcon extends StatelessWidget {
  final BuildContext context;
  final ChannelItem widget;
  final Color iconColor;
  DeleteIcon(
      {@required this.context,
      @required this.widget,
      this.iconColor = Colors.white});
  void deleteIconPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Channel?'),
        titlePadding: EdgeInsets.all(16),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'NO',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ChannelsProvider>(context, listen: false)
                  .deleteChannel(widget.channel.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Channel deleted',
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
            child: Text(
              'YES',
              style: TextStyle(color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: iconColor,
      ),
      onPressed: deleteIconPressed,
    );
  }
}
