import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio/providers/countries_provider.dart';
import '../constatnts.dart';
import 'radio_channels_screen.dart';

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
    // Timer(Duration(seconds: 4), () {
    //   setState(() {
    //     loaded = true;
    //     Navigator.of(context)
    //         .pushReplacementNamed(RadioChannelesScreen.routeName);
    //   });
    // });
    await Provider.of<CountriesProvider>(context, listen: false)
        .updateCountries();
    loaded = true;
    Navigator.of(context).pushReplacementNamed(RadioChannelesScreen.routeName);
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
            )),
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
