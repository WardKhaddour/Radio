import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channels_provider.dart';

class RadioChannelsBottomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: 'All',
          icon: IconButton(
            icon: Icon(Icons.all_out_rounded),
            onPressed: () {
              Provider.of<ChannelsProvider>(context, listen: false).showAll();
            },
          ),
        ),
        BottomNavigationBarItem(
          label: 'Favorite',
          icon: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Provider.of<ChannelsProvider>(context, listen: false).showFav();
            },
          ),
        ),
      ],
    );
  }
}
