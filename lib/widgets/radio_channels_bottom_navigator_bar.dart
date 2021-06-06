import 'package:flutter/material.dart';

class RadioChannelsBottomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: 'All',
          icon: IconButton(
            icon: Icon(Icons.all_out),
            onPressed: () {
              //TODO: toggle to All
            },
          ),
        ),
        BottomNavigationBarItem(
          label: 'Favorite',
          icon: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              //TODO: toggle to fav
            },
          ),
        ),
      ],
    );
  }
}
