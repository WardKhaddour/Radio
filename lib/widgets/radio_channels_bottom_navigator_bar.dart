import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channels_provider.dart';

class RadioChannelsBottomNavigatorBar extends StatefulWidget {
  @override
  _RadioChannelsBottomNavigatorBarState createState() =>
      _RadioChannelsBottomNavigatorBarState();
}

class _RadioChannelsBottomNavigatorBarState
    extends State<RadioChannelsBottomNavigatorBar> {
  int _index = 0;
  void chooseType(int index) {
    if (index == 0) {
      Provider.of<ChannelsProvider>(context, listen: false).showAll();
    } else if (index == 1) {
      Provider.of<ChannelsProvider>(context, listen: false).showFav();
    }
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: chooseType,
      currentIndex: _index,
      items: [
        BottomNavigationBarItem(
          label: 'All',
          icon: Icon(
            Icons.all_out_rounded,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Favorite',
          icon: Icon(
            Icons.favorite,
          ),
        ),
      ],
    );
  }
}
