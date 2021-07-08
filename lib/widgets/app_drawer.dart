import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './drawer_item.dart';
import '../constatnts.dart';
import '../screens/music_screen.dart';
import '../screens/open_url_screen.dart';
import '../screens/radio_channels_screen.dart';
import '../screens/recycle_bin.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _controller;
  ScrollController _scrollController = ScrollController();
  bool _isPinned = false;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (!_isPinned &&
          _scrollController.hasClients &&
          _scrollController.offset > kToolbarHeight) {
        setState(() {
          _isPinned = true;
        });
      } else if (_isPinned &&
          _scrollController.hasClients &&
          _scrollController.offset < kToolbarHeight) {
        setState(() {
          _isPinned = false;
        });
      }
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);
    _controller.reverse();
    super.initState();
  }

  void animate() {
    if (_controller.isCompleted) {
      _controller.reverse();
    }

    _controller.reverse(from: 1);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight:
                _animation.value > 0 ? (_animation.value * 350) : 250,
            automaticallyImplyLeading: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                title: !_isPinned
                    ? Text(
                        'TasQment',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 20),
                      )
                    : Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Hero(tag: 'logo', child: TasQmentLogo())),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'TasQment',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                background: !_isPinned
                    ? GestureDetector(
                        child: Hero(tag: 'logo', child: TasQmentLogo()),
                        onTap: () async {
                          // animate();
                          const url = 'https://www.tasqment.com/';

                          if (await canLaunch(url)) {
                            animate();
                            await launch(url);
                          } else {
                            throw 'Could Not Lunch $url';
                          }
                        },
                      )
                    : Container()),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                DrawerItem(
                  text: 'Radio Channels',
                  icon: Icons.radio,
                  onPress: () {
                    Navigator.of(context).pop();

                    Navigator.of(context)
                        .pushNamed(RadioChannelsScreen.routeName);
                  },
                ),
                Divider(),
                DrawerItem(
                  text: 'My Music',
                  icon: Icons.music_note,
                  onPress: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).pushNamed(MusicScreen.routeName);
                  },
                ),
                Divider(),
                DrawerItem(
                  text: 'Open URL',
                  icon: Icons.web,
                  onPress: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).pushNamed(OpenURLScreen.routeName);
                  },
                ),
                Divider(),
                DrawerItem(
                  text: 'Recycle Bin',
                  icon: Icons.delete,
                  onPress: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(RecycleBin.routeName);
                  },
                ),
                Divider(),
                DrawerItem(
                  text: 'Settings',
                  icon: Icons.settings,
                  onPress: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).pushNamed(SettingsScreen.routeName);
                  },
                ),
                SizedBox(height: 200),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class TasQmentLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Image.asset(logo),
      ),
    );
  }
}
