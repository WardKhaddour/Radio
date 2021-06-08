import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/check_internet_provider.dart';
import '../providers/countries_provider.dart';
import '../constatnts.dart';
import './music_screen.dart';
import './radio_channels_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool loaded = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Provider.of<CheckInternet>(context).getConnectionStatus();
    if (CheckInternet().isConnected) {
      print('connectedddd');
      await Provider.of<CountriesProvider>(context, listen: false)
          .updateCountries();
      loaded = true;
      Navigator.of(context)
          .pushReplacementNamed(RadioChannelesScreen.routeName);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => Container(
          child: NoInternetDialog(context),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (!mounted) {
      CheckInternet().dispose();
    }
    super.dispose();
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
          if (!loaded)
            LinearProgressIndicator(
              backgroundColor: Colors.teal,
            ),
        ],
      ),
    );
  }
}

class NoInternetDialog extends StatelessWidget {
  final BuildContext context;
  NoInternetDialog(this.context);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You Are Not Connected To Internet',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 24,
          ),
        ),
        Image.asset(noSignal),
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  MusicScreen.routeName,
                );
              },
              child: Text(
                'Play Music',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
