import 'package:flutter/material.dart';
import 'drawer_item.dart';
import '../constatnts.dart';
import '../screens/music_screen.dart';
import '../screens/open_url_screen.dart';
import '../screens/radio_channels_screen.dart';

class RadioDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              // Container(
              //   height: 55,
              //   width: double.infinity,
              //   color: Colors.teal,
              // ),
              AppBar(
                automaticallyImplyLeading: false,
              ),
              DrawerItem(
                label: 'Radio Channels',
                onPress: () {
                  Navigator.of(context)
                      .pushNamed(RadioChannelesScreen.routeName);
                },
              ),
              Divider(),
              DrawerItem(
                label: 'My Music',
                onPress: () {
                  Navigator.of(context).pushNamed(MusicScreen.routeName);
                },
              ),
              Divider(),
              DrawerItem(
                label: 'Open URL',
                onPress: () {
                  Navigator.of(context).pushNamed(OpenURLScreen.routeName);
                },
              ),
            ]),
            Container(child: Image.asset(logo)),
          ],
        ),
      ),
    );
  }
}
