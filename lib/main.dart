import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/channels_provider.dart';
import './providers/countries_provider.dart';
import './providers/player_provider.dart';
import './screens/player.dart';
import './screens/open_url_screen.dart';
import './screens/music_screen.dart';
import './screens/radio_channels_screen.dart';
import './screens/welcome_screen.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CountriesProvider()),
        ChangeNotifierProvider.value(value: ChannelsProvider()),
        ChangeNotifierProvider.value(value: PlayerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionsBuilder(),
              TargetPlatform.iOS: CustomPageTransitionsBuilder(),
            },
          ),
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          accentColor: Colors.white,
          fontFamily: 'TitilliumWeb',
          textTheme: TextTheme(
            headline6: TextStyle(fontFamily: 'TitilliumWeb'),
          ),
        ),
        initialRoute: WelcomeScreen.routeName,
        routes: {
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          RadioChannelesScreen.routeName: (ctx) => RadioChannelesScreen(),
          MusicScreen.routeName: (ctx) => MusicScreen(),
          OpenURLScreen.routeName: (ctx) => OpenURLScreen(),
          Player.routeName: (ctx) => Player(),
        },
      ),
    );
  }
}
