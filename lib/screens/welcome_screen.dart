import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/check_internet_provider.dart';
import '../constatnts.dart';
import '../widgets/no_internet_dialog.dart';
import './radio_channels_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _loaded = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      await Provider.of<CheckInternet>(context, listen: false)
          .getConnectionStatus();
      if (CheckInternet().isConnected) {
        _loaded = true;
        Navigator.of(context)
            .pushReplacementNamed(RadioChannelsScreen.routeName);
      } else {
        showDialog(
          context: context,
          builder: (ctx) => NoInternetDialog(context: context),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              backgroundColor: Colors.teal,
            ),
        ],
      ),
    );
  }
}
