import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './drawer_item.dart';
import '../constatnts.dart';
import '../screens/music_screen.dart';
import '../screens/open_url_screen.dart';
import '../screens/radio_channels_screen.dart';
import '../screens/recycle_bin.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                ),
                DrawerItem(
                  label: 'Radio Channels',
                  onPress: () {
                    Navigator.of(context)
                        .pushNamed(RadioChannelsScreen.routeName);
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
                Divider(),
                DrawerItem(
                    label: 'Recycle Bin',
                    onPress: () {
                      Navigator.of(context).pushNamed(RecycleBin.routeName);
                    })
              ],
            ),
            GestureDetector(
              onTap: () async {
                const url = 'https://www.tasqment.com/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could Not Lunch $url';
                }
              },
              child: Container(
                child: Image.asset(logo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
