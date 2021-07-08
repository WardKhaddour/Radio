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
  String _theme = 'Light';
  String _defaultScreen = 'Radio';
  SharedPreferences pref;
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
            ListTile(
              title: Text('Set Default'),
              trailing: DropdownButton(
                value: _defaultScreen,
                items: ['Radio', 'Music Player']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: pref != null
                        ? pref.getString('default screen') != null
                            ? pref.getString('default screen')
                            : 'Radio'
                        : value,
                  );
                }).toList(),
                onChanged: (String value) async {
                  setState(() {
                    _defaultScreen = value;
                  });
                  pref = await SharedPreferences.getInstance();
                  pref.setString('default screen', value);
                },
              ),
            ),
            ListTile(
              title: Text('Theme'),
              trailing: DropdownButton(
                value: _theme,
                items: ['Dark', 'Light']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    _theme = value;
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(value);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
