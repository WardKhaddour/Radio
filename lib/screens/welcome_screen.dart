import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/background_audio_player.dart';
import '../providers/check_internet_provider.dart';
import '../constatnts.dart';
import '../widgets/no_internet_dialog.dart';
import './radio_channels_screen.dart';
import './music_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool _loaded = false;
  AnimationController _controller;
  Animation _animation;
  String route;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = ColorTween(begin: Colors.teal.shade300, end: Colors.white)
        .animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    Future.delayed(Duration(seconds: 0)).then((value) async {
      await initAudioService();
      final pref = await SharedPreferences.getInstance();
      route = pref.getString('default screen') ?? 'Radio';
      if (await Provider.of<CheckInternet>(context, listen: false)
          .getConnectionStatus()) {
        Timer(Duration(seconds: 2), () {
          _loaded = true;

          Navigator.of(context).pushReplacementNamed(route == 'Radio'
              ? RadioChannelsScreen.routeName
              : MusicScreen.routeName);
        });
      } else {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) => NoInternetDialog(),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    AudioService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Image(
                image: AssetImage(
                  radioImage,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  'One App',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'All Radio Channels!',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          if (!_loaded)
            LinearProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
        ],
      ),
    );
  }
}
