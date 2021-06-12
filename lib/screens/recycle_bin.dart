import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channels_provider.dart';
import '../models/channel.dart';
import '../widgets/app_drawer.dart';

class RecycleBin extends StatefulWidget {
  static const routeName = 'recycle-bin';
  @override
  _RecycleBinState createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  List<Channel> _channels = [];
  @override
  Widget build(BuildContext context) {
    _channels = Provider.of<ChannelsProvider>(context).deletedChannels;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycle Bin'),
      ),
      drawer: AppDrawer(),
      body: _channels.isEmpty
          ? Center(
              child: Text(
                'No Items',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _channels.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  _channels[index].name,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore_from_trash),
                  onPressed: () {
                    Provider.of<ChannelsProvider>(context, listen: false)
                        .restoreChannel(_channels[index].id);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Channel Restored',
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
                ),
              ),
            ),
    );
  }
}