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
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      // selectedIconTheme: IconThemeData(color: Colors.teal),
      items: [
        BottomNavigationBarItem(
          label: 'All',
          icon: IconButton(
            icon: Icon(
              Icons.all_out_rounded,
              // color: _fav ? Colors.grey : Colors.teal,
            ),
            onPressed: () {
              Provider.of<ChannelsProvider>(context, listen: false).showAll();
              // setState(() {});
            },
          ),
        ),
        BottomNavigationBarItem(
          label: 'Favorite',
          icon: IconButton(
            icon: Icon(
              Icons.favorite,
              // color: !_fav ? Colors.grey : Colors.teal,
            ),
            onPressed: () {
              Provider.of<ChannelsProvider>(context, listen: false).showFav();
              // setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
