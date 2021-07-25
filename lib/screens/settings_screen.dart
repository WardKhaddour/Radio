import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/appbar_flexible_space.dart';
import '../widgets/background.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _useMusicPlayer = false;
  SharedPreferences _pref;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) async {
      _pref = await SharedPreferences.getInstance();
      setState(() {
        _useMusicPlayer = _pref.getBool('default screen') ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        flexibleSpace: AppBarFlexibleSpace(),
      ),
      body: BackGround(
        child: ListView(
          children: [
            SwitchListTile(
              activeColor: Colors.teal,
              title: Text('Use Music Player as Default'),
              value: _useMusicPlayer,
              onChanged: (bool value) async {
                setState(() {
                  _useMusicPlayer = value;
                });
                _pref = await SharedPreferences.getInstance();
                _pref.setBool('default screen', value);
              },
            ),
            SwitchListTile(
              activeColor: Colors.teal,
              value: Provider.of<ThemeProvider>(context).isDarkTheme,
              title: Text('Use Dark Theme'),
              onChanged: (value) async {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(value);
                _pref = await SharedPreferences.getInstance();
                _pref.setBool('use dark theme', value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
