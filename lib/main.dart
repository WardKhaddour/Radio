import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/music_provider.dart';
import './providers/theme_provider.dart';
import './providers/channels_provider.dart';
import './providers/countries_provider.dart';
import './providers/player_provider.dart';
import './providers/check_internet_provider.dart';
import './screens/recycle_bin.dart';
import './screens/open_url_screen.dart';
import './screens/music_screen.dart';
import './screens/radio_channels_screen.dart';
import './screens/welcome_screen.dart';
import './screens/player.dart';
import './screens/settings_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: CountriesProvider()),
    ChangeNotifierProvider.value(value: ChannelsProvider()),
    ChangeNotifierProvider.value(value: PlayerProvider()),
    ChangeNotifierProvider.value(value: MusicProvider()),
    ChangeNotifierProvider.value(value: CheckInternet()),
    ChangeNotifierProvider.value(value: ThemeProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).theme,
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
        RadioChannelsScreen.routeName: (ctx) => RadioChannelsScreen(),
        MusicScreen.routeName: (ctx) => MusicScreen(),
        OpenURLScreen.routeName: (ctx) => OpenURLScreen(),
        Player.routeName: (ctx) => Player(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
        RecycleBin.routeName: (ctx) => RecycleBin(),
      },
    );
  }
}
