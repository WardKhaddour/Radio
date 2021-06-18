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
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            titleSpacing: 400,
            automaticallyImplyLeading: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'TasQment',
                style: TextStyle(
                    color: Colors.grey.withOpacity(0.7), fontSize: 20),
                textAlign: TextAlign.center,
              ),
              background: GestureDetector(
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
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                DrawerItem(
                  text: 'Radio Channels',
                  icon: Icons.radio,
                  onPress: () {
                    Navigator.of(context)
                        .pushNamed(RadioChannelsScreen.routeName);
                  },
                ),
                Divider(),
                DrawerItem(
                  text: 'My Music',
                  icon: Icons.music_note,
                  onPress: () {
                    Navigator.of(context).pushNamed(MusicScreen.routeName);
                  },
                ),
                Divider(),
                DrawerItem(
                  text: 'Open URL',
                  icon: Icons.web,
                  onPress: () {
                    Navigator.of(context).pushNamed(OpenURLScreen.routeName);
                  },
                ),
                Divider(),
                DrawerItem(
                  text: 'Recycle Bin',
                  icon: Icons.delete,
                  onPress: () {
                    Navigator.of(context).pushNamed(RecycleBin.routeName);
                  },
                ),
                Divider(),
                SizedBox(height: 8000),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
