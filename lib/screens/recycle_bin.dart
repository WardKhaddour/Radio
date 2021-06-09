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
      body: ListView.builder(
        itemCount: _channels.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            _channels[index].name,
          ),
          trailing: IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<ChannelsProvider>(context, listen: false)
                  .restoreChannel(_channels[index].id);
            },
          ),
        ),
      ),
    );
  }
}
